#include "core.h"

/* system */
void get_os(lua_State *L);
void get_kernel(lua_State *L);
void get_uptime(lua_State *L);

/* hardware */
void get_cpu(lua_State *L);
void get_gpu(lua_State *L);
void get_memory(lua_State *L);
void get_disk(lua_State *L);

/* environment */
void get_shell(lua_State *L);
void get_terminal(lua_State *L);
void get_wm(lua_State *L);

/* user/system info */
void get_user(lua_State *L);
void get_host(lua_State *L);
void get_vendor(lua_State *L);

/* art */
void get_art(lua_State *L);
void get_color(lua_State *L);

module_t modules[] = {
    /* system */
    {"os", get_os},
    {"kernel", get_kernel},
    {"uptime", get_uptime},

    /* hardware */
    {"cpu", get_cpu},
    {"gpu", get_gpu},
    {"memory", get_memory},
    {"disk", get_disk},

    /* environment */
    {"shell", get_shell},
    {"terminal", get_terminal},
    {"wm", get_wm},

    /* user/system */
    {"user", get_user},
    {"host", get_host},
    {"vendor", get_vendor},

    /* art */
    {"art", get_art},
    {"color", get_color}
};

int module_count = sizeof(modules) / sizeof(modules[0]);
