#include "util.h"
#include <lua.h>
#include <sys/utsname.h>

void get_kernel(lua_State *L) {
    static struct utsname u;

    if (uname(&u) != 0) {
        set_table_string(L, "kernel", "name", "unknown");
        return;
    }
    
    set_table_string(L, "kernel", "sysname", u.sysname);
    set_table_string(L, "kernel", "release", u.release);
}
