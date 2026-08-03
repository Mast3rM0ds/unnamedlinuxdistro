#include <lua.h>
#include <stdio.h>
#include <string.h>
#include "util.h"

void get_os(lua_State *L) {
    static char buffer[128];
    FILE *f = fopen("/etc/os-release", "r");

    if (!f) {
        set_table_string(L, "os", "name", "unknown");
        return;
    }
    
    while (fgets(buffer, sizeof(buffer), f)) {
        if (strncmp(buffer, "PRETTY_NAME=", 12) == 0) {

            char *start = strchr(buffer, '=') + 1;

            start[strcspn(start, "\n")] = 0;

            strip_quotes(start);

            set_table_string(L, "os", "name", start);

            fclose(f);
            return;
        }
    }

    fclose(f);
    set_table_string(L, "os", "name", "unknown");
}
