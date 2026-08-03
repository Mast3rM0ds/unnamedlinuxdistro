#ifndef UTIL_H
#define UTIL_H

#include <lua.h>

void strip_quotes(char *s);
void set_table_string(lua_State *L, const char *table, const char *key, const char *value);
void set_table_number(lua_State *L, const char *table, const char *key, double value);

#endif

