#include "util.h"
#include <lua.h>
#include <stdio.h>
#include <string.h>

static char out[256];

static const char *try_vulkan() {
    FILE *p = popen("vulkaninfo --summary 2>/dev/null | grep deviceName", "r");
    if (!p) return NULL;

    if (!fgets(out, sizeof(out), p)) {
        pclose(p);
        return NULL;
    }
    pclose(p);

    char *eq = strchr(out, '=');
    if (!eq) return NULL;

    eq++;
    while (*eq == ' ' || *eq == '\t') eq++;

    eq[strcspn(eq, "\n")] = 0;
    return (*eq) ? eq : NULL;
}

static const char *try_glx() {
    FILE *p = popen("glxinfo 2>/dev/null | grep -i 'renderer string'", "r");
    if (!p) return NULL;

    if (!fgets(out, sizeof(out), p)) {
        pclose(p);
        return NULL;
    }
    pclose(p);

    char *c = strchr(out, ':');
    if (!c) return NULL;

    c++;
    while (*c == ' ') c++;

    c[strcspn(c, "\n")] = 0;
    return (*c) ? c : NULL;
}

static const char *try_lspci() {
    FILE *p = popen("lspci | grep -E 'VGA|3D'", "r");
    if (!p) return NULL;

    if (!fgets(out, sizeof(out), p)) {
        pclose(p);
        return NULL;
    }
    pclose(p);

    char *gpu = strchr(out, ':');
    if (!gpu) return NULL;

    gpu++;
    while (*gpu == ' ') gpu++;

    char *rev = strstr(gpu, " (rev");
    if (rev) *rev = '\0';

    gpu[strcspn(gpu, "\n")] = 0;
    return (*gpu) ? gpu : NULL;
}

void get_gpu(lua_State *L) {
    const char *gpu = try_vulkan();
    if (!gpu) gpu = try_glx();
    if (!gpu) gpu = try_lspci();

    if (!gpu) gpu = "unknown";

    set_table_string(L, "gpu", "name", gpu);
}
