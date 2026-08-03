#include <stdlib.h>
#include "util.h"
#include <lua.h>
#include <string.h>

void get_shell(lua_State *L) {
    const char *shell = getenv("SHELL");
    if (!shell) shell = "unknown";

    set_table_string(L, "shell", "path", shell);

    const char *name = strrchr(shell, '/');
    set_table_string(L, "shell", "name", name ? name + 1 : shell);
}
