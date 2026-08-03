#include <lua.h>
#include <lauxlib.h>
#include <stdio.h>

#define ANSI(code) "\033[" code "m"

static const char *colors[] = {
    "black", "red", "green", "yellow",
    "blue", "magenta", "cyan", "white", NULL
};

static int l_color(lua_State *L) {
    int code = (int)lua_tointeger(L, lua_upvalueindex(1));
    const char *s = luaL_checkstring(L, 1);
    lua_pushfstring(L, "\033[%dm%s\033[0m", code, s);
    return 1;
}

static int l_bold(lua_State *L) {
    const char *s = luaL_checkstring(L, 1);
    lua_pushfstring(L, "\033[1m%s\033[0m", s);
    return 1;
}

static int l_reset(lua_State *L) {
    lua_pushstring(L, "\033[0m");
    return 1;
}

void get_color(lua_State *L) {
    lua_newtable(L);

    for (int i = 0; colors[i]; i++) {
        lua_pushinteger(L, 30 + i);
        lua_pushcclosure(L, l_color, 1);
        lua_setfield(L, -2, colors[i]);
    }

    char bright[32];
    for (int i = 0; colors[i]; i++) {
        snprintf(bright, sizeof(bright), "bright_%s", colors[i]);
        lua_pushinteger(L, 90 + i);
        lua_pushcclosure(L, l_color, 1);
        lua_setfield(L, -2, bright);
    }

    lua_pushcfunction(L, l_bold);
    lua_setfield(L, -2, "bold");

    lua_pushcfunction(L, l_reset);
    lua_setfield(L, -2, "reset");

    lua_setglobal(L, "color");
}
