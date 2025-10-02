#include <assert.h>
#include <ctype.h>
#include <errno.h>
#include <getopt.h>
#include <libgen.h>
#include <limits.h>
#include <math.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#ifdef DEBUG
#define DBUG(x) x
#else
#define DBUG(x)
#endif

#define print_debug(...) DBUG(printf(__VA_ARGS__))

#ifndef ARRAY_SIZE
#define ARRAY_SIZE(x) (sizeof(x) / sizeof(0 [x]))
#endif

int
main(int argc, char *argv[])
{
  (void)argc;
  (void)argv;

  printf("\nHello World!\n");
  printf("%s:%d\n", __FILE__, __LINE__);

  print_debug("\n*** Development build\n");
  print_debug("Build: %s %s\n", __DATE__, __TIME__);

  return EXIT_SUCCESS;
}
