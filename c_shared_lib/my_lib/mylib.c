#include "mylib.h"

#ifdef DEBUG
#define DBUG(x) x
#else
#define DBUG(x)
#endif

#define print_debug(...) DBUG(printf(__VA_ARGS__))

#ifndef ARRAY_SIZE
#define ARRAY_SIZE(x) (sizeof(x) / sizeof(0 [x]))
#endif

void
hello_my_lib(const char *str)
{
  print_debug("\n%s:%d\n", __FILE__, __LINE__);
  print_debug("Build: %s %s\n", __DATE__, __TIME__);
  printf("\n%s\n", str);
}
