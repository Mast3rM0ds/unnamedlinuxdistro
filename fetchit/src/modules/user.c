#include <stdlib.h>
#include "util.h"
#include <lua.h>

void get_user(lua_State *L) {
    const char *user = getenv("USER");
    if (!user) user = "unknown";

    set_table_string(L, "user", "name", user);
}
