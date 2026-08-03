#include <lua.h>
#include <lauxlib.h>
#include <stdio.h>
#include <string.h>

void get_art(lua_State *L) {
    lua_getglobal(L, "art");

    if (!lua_istable(L, -1)) {
        lua_pop(L, 1);
        lua_newtable(L);
        lua_setglobal(L, "art");
        return;
    }

    lua_getfield(L, -1, "source");

    if (!lua_isstring(L, -1)) {
        lua_pop(L, 2);
        return;
    }

    const char *path = lua_tostring(L, -1);
    lua_pop(L, 1);

    // get config dir
    lua_getfield(L, LUA_REGISTRYINDEX, "fetchit_config_path");
    const char *config_path = lua_tostring(L, -1);
    lua_pop(L, 1);

    char config_dir[1024];
    strncpy(config_dir, config_path, sizeof(config_dir) - 1);
    char *last_slash = strrchr(config_dir, '/');
    if (last_slash) *last_slash = '\0';


    char full_path[2048];
    snprintf(full_path, sizeof(full_path), "%s/%s", config_dir, path);

    FILE *f = fopen(full_path, "r");

    lua_newtable(L);

    if (!f) {
        lua_pushstring(L, "");
        lua_rawseti(L, -2, 1);

        lua_setfield(L, -2, "out");
        lua_pop(L, 1);
        return;
    }

    char line[256];
    int i = 1;

    while (fgets(line, sizeof(line), f)) {
        line[strcspn(line, "\n")] = 0;

        lua_pushstring(L, line);
        lua_rawseti(L, -2, i++);
    }

    fclose(f);

    lua_setfield(L, -2, "out");

    lua_pop(L, 1);
}
