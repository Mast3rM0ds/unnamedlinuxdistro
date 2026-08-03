#include "util.h"
#include <string.h>
#include <lua.h>

void strip_quotes(char *s) {
    if (!s) return;

    size_t len = strlen(s);

    if (s[0] == '"') {
        memmove(s, s + 1, len);
        len--;
    }

    if (len > 0 && s[len - 1] == '"') {
        s[len - 1] = 0;
    }
}

void set_table_string(lua_State *L, const char *table, const char *key, const char *value) {
    lua_getglobal(L, table);

    if (!lua_istable(L, -1)) {
        lua_pop(L, 1);
        lua_newtable(L);
    }

    lua_pushstring(L, value);
    lua_setfield(L, -2, key);

    lua_setglobal(L, table);
}

void set_table_number(lua_State *L, const char *table, const char *key, double value) {
    lua_getglobal(L, table);

    if (!lua_istable(L, -1)) {
        lua_pop(L, 1);
        lua_newtable(L);
    }

    lua_pushnumber(L, value);
    lua_setfield(L, -2, key);

    lua_setglobal(L, table);
}
