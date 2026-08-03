#include <sys/statvfs.h>
#include "util.h"
#include <lua.h>

void get_disk(lua_State *L) {
    struct statvfs stat;

    if (statvfs("/", &stat) != 0) {
        set_table_string(L, "disk", "status", "unknown");
        return;
    }

    double total = (double)stat.f_blocks * stat.f_frsize;
    double free  = (double)stat.f_bfree  * stat.f_frsize;
    double used  = total - free;

    double total_gb = total / 1024 / 1024 / 1024;
    double used_gb  = used  / 1024 / 1024 / 1024;

    set_table_number(L, "disk", "total_gb", total_gb);
    set_table_number(L, "disk", "used_gb", used_gb);
}
