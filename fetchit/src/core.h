#ifndef CORE_H
#define CORE_H

#include <lua.h>

typedef void (*module_fn)(lua_State *L);

typedef struct {
  const char *name;
  module_fn fn;
} module_t;

#endif
