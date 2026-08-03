#include <stdlib.h>
#include "util.h"
#include <lua.h>

void get_terminal(lua_State *L) {
    const char *term = getenv("TERM");
    if (!term) term = "unknown";

    set_table_string(L, "terminal", "name", term);
}
