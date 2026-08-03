#include <stdlib.h>
#include "util.h"
#include <lua.h>

void get_wm(lua_State *L) {
    const char *wm = getenv("XDG_CURRENT_DESKTOP");
    if (!wm) wm = getenv("DESKTOP_SESSION");
    if (!wm) wm = "unknown";

    set_table_string(L, "wm", "name", wm);
}
