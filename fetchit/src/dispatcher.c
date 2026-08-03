#include "dispatcher.h"
#include "core.h"

extern module_t modules[];
extern int module_count;

void run_modules(lua_State *L) {
    for (int i = 0; i < module_count; i++) {
        modules[i].fn(L);
    }
}
