#include <stdio.h>
#include <string.h>
#include "util.h"
#include <lua.h>

static void read_file_trim(const char *path, char *out, size_t size) {
    FILE *f = fopen(path, "r");
    if (!f) {
        strncpy(out, "unknown", size);
        return;
    }

    if (!fgets(out, size, f)) {
        strncpy(out, "unknown", size);
        fclose(f);
        return;
    }

    fclose(f);

    out[strcspn(out, "\n")] = 0;
}

void get_vendor(lua_State *L) {
    char vendor[128];
    char product[128];

    read_file_trim("/sys/devices/virtual/dmi/id/sys_vendor", vendor, sizeof(vendor));
    read_file_trim("/sys/devices/virtual/dmi/id/product_name", product, sizeof(product));

    set_table_string(L, "vendor", "name", vendor);
    set_table_string(L, "vendor", "model", product);
}
