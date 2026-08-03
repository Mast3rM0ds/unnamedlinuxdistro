#include "util.h"
#include <lua.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

static long parse_kb(const char *line) {
    return atol(line);
}

void get_memory(lua_State *L) {
    static char line[256];

    FILE *f = fopen("/proc/meminfo", "r");
    if (!f) {
        set_table_string(L, "memory", "status", "unknown");
        set_table_number(L, "memory", "total_gb", 0);
        set_table_number(L, "memory", "used_gb", 0);
        set_table_number(L, "memory", "available_gb", 0);
        set_table_number(L, "memory", "percent", 0);
        return;
    }

    long total = 0;
    long available = 0;

    while (fgets(line, sizeof(line), f)) {
        if (strncmp(line, "MemTotal:", 9) == 0)
            total = parse_kb(line + 9);

        if (strncmp(line, "MemAvailable:", 13) == 0)
            available = parse_kb(line + 13);
    }

    fclose(f);

    if (total == 0) {
        set_table_string(L, "memory", "status", "unknown");
        set_table_number(L, "memory", "total_gb", 0);
        set_table_number(L, "memory", "used_gb", 0);
        set_table_number(L, "memory", "available_gb", 0);
        set_table_number(L, "memory", "percent", 0);
        return;
    }

    long used = total - available;

    double total_gb = total / 1024.0 / 1024.0;
    double used_gb  = used  / 1024.0 / 1024.0;
    double avail_gb = available / 1024.0 / 1024.0;
    double percent  = (used * 100.0) / total;

    set_table_number(L, "memory", "total_gb", total_gb);
    set_table_number(L, "memory", "used_gb", used_gb);
    set_table_number(L, "memory", "available_gb", avail_gb);
    set_table_number(L, "memory", "percent", percent);
}
