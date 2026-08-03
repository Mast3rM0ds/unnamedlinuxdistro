#include <stdio.h>
#include "util.h"
#include <lua.h>

void get_uptime(lua_State *L) {
    FILE *f = fopen("/proc/uptime", "r");
    if (!f) {
        set_table_string(L, "uptime", "pretty", "unknown");
        return;
    }

    double seconds;
    fscanf(f, "%lf", &seconds);
    fclose(f);

    int hours = seconds / 3600;
    int minutes = ((int)seconds % 3600) / 60;

    char out[64];
    snprintf(out, sizeof(out), "%dh %dm", hours, minutes);

    set_table_string(L, "uptime", "pretty", out);
    set_table_number(L, "uptime", "seconds", seconds);
}
