#define _XOPEN_SOURCE 700
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <wchar.h>
#include <locale.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
#include "dispatcher.h"

#define MAX_COLS 16

typedef struct {
    int ref;
    int height;
    int width;
} column_t;

static int visible_width(const char *s) {
    int w = 0;
    wchar_t wc;
    mbstate_t state = {0};
    while (*s) {
        if (*s == '\033') {
            while (*s && *s != 'm') s++;
            if (*s) s++;
            continue;
        }
        size_t n = mbrtowc(&wc, s, MB_CUR_MAX, &state);
        if (n == (size_t)-1 || n == (size_t)-2) { s++; continue; }
        int cw = wcwidth(wc);
        if (cw > 0) w += cw;
        s += n;
    }
    return w;
}

const char *get_config_path(int argc, char **argv) {
    static char path[512];

    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-c") == 0 && i + 1 < argc) {
            return argv[i + 1];
        }
    }

    const char *xdg = getenv("XDG_CONFIG_HOME");
    const char *home = getenv("HOME");

    if (xdg && xdg[0]) {
        snprintf(path, sizeof(path), "%s/fetchit/init.lua", xdg);
        return path;
    }

    if (home && home[0]) {
        snprintf(path, sizeof(path), "%s/.config/fetchit/init.lua", home);
        return path;
    }

    return "config/fetchit/init.lua";
}

static int load_config(lua_State *L, int argc, char **argv) {
  const char *cfg = get_config_path(argc, argv);
    if (luaL_dofile(L, cfg) != LUA_OK) {
        fprintf(stderr, "lua error: %s\n", lua_tostring(L, -1));
        return 0;
    }
    lua_pushstring(L, cfg);
    lua_setfield(L, LUA_REGISTRYINDEX, "fetchit_config_path");
    return 1;
}

static int get_padding(lua_State *L) {
    int padding = 2;
    lua_getglobal(L, "column_padding");
    if (lua_isnumber(L, -1))
        padding = lua_tointeger(L, -1);
    lua_pop(L, 1);
    return padding;
}

static int call_fetch(lua_State *L) {
    lua_getglobal(L, "fetch");
    if (!lua_isfunction(L, -1)) {
        fprintf(stderr, "fetch() not found\n");
        return 0;
    }
    if (lua_pcall(L, 0, 1, 0) != LUA_OK) {
        fprintf(stderr, "lua runtime error: %s\n", lua_tostring(L, -1));
        return 0;
    }
    return 1;
}

static int load_columns(lua_State *L, column_t *cols, int *col_count, int *max_rows) {
    lua_getfield(L, -1, "columns");
    if (!lua_istable(L, -1)) {
        fprintf(stderr, "fetch.columns missing\n");
        return 0;
    }

    int count = (int)lua_rawlen(L, -1);
    if (count > MAX_COLS) {
        fprintf(stderr, "warning: clamping %d columns to %d\n", count, MAX_COLS);
        count = MAX_COLS;
    }
    *col_count = count;

    for (int c = 0; c < count; c++) {
        lua_rawgeti(L, -1, c + 1);
        if (!lua_istable(L, -1)) {
            fprintf(stderr, "column %d is not a table\n", c + 1);
            return 0;
        }

        cols[c].ref = luaL_ref(L, LUA_REGISTRYINDEX);
        lua_rawgeti(L, LUA_REGISTRYINDEX, cols[c].ref);

        int len = (int)lua_rawlen(L, -1);
        cols[c].height = len;
        if (len > *max_rows)
            *max_rows = len;

        int max_width = 0;
        for (int i = 1; i <= len; i++) {
            lua_rawgeti(L, -1, i);
            const char *s = lua_tostring(L, -1);
            int w = s ? visible_width(s) : 0;
            if (w > max_width)
                max_width = w;
            lua_pop(L, 1);
        }
        cols[c].width = max_width;
        lua_pop(L, 1);
    }

    lua_pop(L, 1);
    return 1;
}

static void print_table(lua_State *L, column_t *cols, int col_count, int max_rows, int padding) {
    for (int row = 0; row < max_rows; row++) {
        for (int c = 0; c < col_count; c++) {
            lua_rawgeti(L, LUA_REGISTRYINDEX, cols[c].ref);
            if (row < cols[c].height) {
                lua_rawgeti(L, -1, row + 1);
                const char *s = lua_tostring(L, -1);
                int vw = s ? visible_width(s) : 0;

                int pad = cols[c].width + padding - vw;
                if (pad < 0) pad = 0;

                if (c != col_count - 1) {
                  printf("%s%-*s", s ? s : "", pad, "");
                } else {
                  printf("%s", s ? s : "");
                }
                lua_pop(L, 1);
            } else {
                if (c != col_count - 1) {
                  printf("%-*s", cols[c].width + padding, "");
                }
            }
            lua_pop(L, 1);
        }
        printf("\n");
    }
}

static void free_columns(lua_State *L, column_t *cols, int col_count) {
    for (int c = 0; c < col_count; c++)
        luaL_unref(L, LUA_REGISTRYINDEX, cols[c].ref);
}

int main(int argc, char **argv) {
    setlocale(LC_ALL, "");
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    if (!load_config(L, argc, argv))  { lua_close(L); return 1; }
    run_modules(L);
    int padding = get_padding(L);
    if (!call_fetch(L))   { lua_close(L); return 1; }

    column_t cols[MAX_COLS];
    int col_count = 0;
    int max_rows  = 0;

    if (!load_columns(L, cols, &col_count, &max_rows)) {
        lua_close(L);
        return 1;
    }

    print_table(L, cols, col_count, max_rows, padding);
    free_columns(L, cols, col_count);
    lua_close(L);
    return 0;
}
