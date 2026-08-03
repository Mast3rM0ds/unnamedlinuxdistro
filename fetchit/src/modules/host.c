#include <unistd.h>
#include "util.h"
#include <lua.h>

void get_host(lua_State *L) {
    char buf[128];

    if (gethostname(buf, sizeof(buf)) != 0) {
        set_table_string(L, "host", "name", "unknown");
        return;
    }

    set_table_string(L, "host", "name", buf);
}
