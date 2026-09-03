/* lua_recipe.c
 *
 * A recipe is a real .lua file that returns a table:
 *
 *   return {
 *     name = "wayland",
 *     version = "1.23.0",
 *     description = "Core Wayland protocol libraries",
 *     license = "MIT",
 *     homepage = "https://wayland.freedesktop.org",
 *     sources = {
 *       { url = "https://.../wayland-1.23.0.tar.xz", sha256 = "..." },
 *     },
 *     deps = {
 *       { name = "libffi" },
 *       { name = "expat" },
 *       { name = "meson", build_only = true },
 *     },
 *     build = {
 *       "meson setup build --prefix=$out",
 *       "ninja -C build",
 *       "ninja -C build install",
 *     },
 *   }
 *
 * No custom evaluator, no purity model, no lazy thunks — it's a Lua
 * script that returns a table. You can use loops, string interpolation,
 * conditionals on host arch, `require()` a shared helper module, whatever
 * Lua already gives you. That's the whole DSL.
 */
#include "bloink.h"
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
#include <string.h>
#include <stdio.h>

static void copy_field_str(lua_State *L, const char *key, char *dst, size_t dstlen) {
    lua_getfield(L, -1, key);
    if (lua_isstring(L, -1)) {
        const char *s = lua_tostring(L, -1);
        snprintf(dst, dstlen, "%s", s);
    } else {
        dst[0] = 0;
    }
    lua_pop(L, 1);
}

static int load_sources(lua_State *L, BloinkPackage *pkg) {
    lua_getfield(L, -1, "sources");
    if (!lua_istable(L, -1)) { lua_pop(L, 1); return 0; }

    int n = (int)lua_rawlen(L, -1);
    for (int i = 1; i <= n && pkg->n_sources < BLOINK_MAX_SOURCES; ++i) {
        lua_rawgeti(L, -1, i);
        if (lua_istable(L, -1)) {
            BloinkSource *s = &pkg->sources[pkg->n_sources];
            copy_field_str(L, "url", s->url, sizeof(s->url));
            copy_field_str(L, "sha256", s->sha256, sizeof(s->sha256));
            copy_field_str(L, "dest", s->dest, sizeof(s->dest));
            if (s->sha256[0] == 0) {
                fprintf(stderr, "bloink: source %s has no sha256 — refusing "
                                "to add an unverifiable fetch\n", s->url);
                lua_pop(L, 1); lua_pop(L, 1);
                return -1;
            }
            pkg->n_sources++;
        }
        lua_pop(L, 1);
    }
    lua_pop(L, 1);
    return 0;
}

static int load_deps(lua_State *L, BloinkPackage *pkg) {
    lua_getfield(L, -1, "deps");
    if (!lua_istable(L, -1)) { lua_pop(L, 1); return 0; }

    int n = (int)lua_rawlen(L, -1);
    for (int i = 1; i <= n && pkg->n_deps < BLOINK_MAX_DEPS; ++i) {
        lua_rawgeti(L, -1, i);
        if (lua_istable(L, -1)) {
            BloinkDep *d = &pkg->deps[pkg->n_deps];
            copy_field_str(L, "name", d->name, sizeof(d->name));
            copy_field_str(L, "constraint", d->constraint, sizeof(d->constraint));
            lua_getfield(L, -1, "build_only");
            d->build_only = lua_isboolean(L, -1) && lua_toboolean(L, -1);
            lua_pop(L, 1);
            if (d->name[0]) pkg->n_deps++;
        } else if (lua_isstring(L, -1)) {
            BloinkDep *d = &pkg->deps[pkg->n_deps];
            snprintf(d->name, sizeof(d->name), "%s", lua_tostring(L, -1));
            d->constraint[0] = 0; d->build_only = 0;
            pkg->n_deps++;
        }
        lua_pop(L, 1);
    }
    lua_pop(L, 1);
    return 0;
}

static int load_build_steps(lua_State *L, BloinkPackage *pkg) {
    lua_getfield(L, -1, "build");
    if (!lua_istable(L, -1)) { lua_pop(L, 1); return 0; }

    int n = (int)lua_rawlen(L, -1);
    for (int i = 1; i <= n && pkg->n_steps < BLOINK_MAX_STEPS; ++i) {
        lua_rawgeti(L, -1, i);
        if (lua_isstring(L, -1)) {
            snprintf(pkg->steps[pkg->n_steps], sizeof(pkg->steps[0]),
                     "%s", lua_tostring(L, -1));
            pkg->n_steps++;
        }
        lua_pop(L, 1);
    }
    lua_pop(L, 1);
    return 0;
}

int bloink_load_recipe(const char *path, BloinkPackage *out) {
    memset(out, 0, sizeof(*out));
    snprintf(out->recipe_path, sizeof(out->recipe_path), "%s", path);

    lua_State *L = luaL_newstate();
    if (!L) return -1;
    luaL_openlibs(L);

    /* expose a couple of host facts recipes can branch on, e.g.
     *   if bloink.arch == "aarch64" then ... end
     * This is plain Lua control flow — no macro layer needed. */
    lua_newtable(L);
#if defined(__aarch64__)
    lua_pushstring(L, "aarch64");
#elif defined(__x86_64__)
    lua_pushstring(L, "x86_64");
#else
    lua_pushstring(L, "unknown");
#endif
    lua_setfield(L, -2, "arch");
    lua_pushstring(L, "linux-musl");
    lua_setfield(L, -2, "libc");
    lua_setglobal(L, "bloink");

    if (luaL_dofile(L, path) != LUA_OK) {
        fprintf(stderr, "bloink: error loading recipe %s: %s\n",
                path, lua_tostring(L, -1));
        lua_close(L);
        return -1;
    }

    if (!lua_istable(L, -1)) {
        fprintf(stderr, "bloink: recipe %s did not return a table\n", path);
        lua_close(L);
        return -1;
    }

    copy_field_str(L, "name", out->name, sizeof(out->name));
    copy_field_str(L, "version", out->version, sizeof(out->version));
    copy_field_str(L, "description", out->description, sizeof(out->description));
    copy_field_str(L, "license", out->license, sizeof(out->license));
    copy_field_str(L, "homepage", out->homepage, sizeof(out->homepage));

    if (out->name[0] == 0) {
        fprintf(stderr, "bloink: recipe %s has no name\n", path);
        lua_close(L);
        return -1;
    }

    int rc = 0;
    rc |= load_sources(L, out);
    rc |= load_deps(L, out);
    rc |= load_build_steps(L, out);

    lua_getfield(L, -1, "service");
    if (lua_istable(L, -1)) {
        /* Serialize the service table back to a small Lua literal so an
         * init adapter can load it independently. bloink does not
         * interpret this — it's the adapter's job (runit/s6/openrc/
         * dinit/whatever the user picked, since init is swappable). */
        lua_getglobal(L, "tostring");
        (void)L; /* keep it simple: just record that a service exists;
                     full serialization happens in profile.c via a
                     dedicated dump, kept out of this file for size */
        out->has_service = 1;
    }
    lua_pop(L, 1);

    lua_close(L);
    return 0;
}
