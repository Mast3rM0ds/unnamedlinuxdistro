#include "util.h"
#include <lua.h>
#include <stdio.h>
#include <string.h>

void get_cpu(lua_State *L) {
    static char line[256];

    FILE *f = fopen("/proc/cpuinfo", "r");
    if (!f) {
        set_table_string(L, "cpu", "name", "unknown");
        return;
    }

    lua_newtable(L);

    while (fgets(line, sizeof(line), f)) {
        if (strncmp(line, "model name", 10) == 0) {

            char *value = strchr(line, ':');
            if (!value) break;

            value += 2;
            value[strcspn(value, "\n")] = 0;

            strip_quotes(value);

            set_table_string(L, "cpu", "name", value);
            break;
        }
    }

    fclose(f);
}
