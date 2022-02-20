#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <libgen.h>
#include <errno.h>
#include <string.h>
#include <getopt.h>
#include <sys/types.h>
#include <stdbool.h>
#include <sys/stat.h>
#include <limits.h>
#include <assert.h>
#include <stdint.h>

#ifdef DEBUG
#define DEBUG_PRINT(...) printf(__VA_ARGS__)
#else
#define DEBUG_PRINT(...)
#endif

#define ARRAY_SIZE(x) \
  ((sizeof(x) / sizeof(0 [x])) / ((size_t)(!(sizeof(x) % sizeof(0 [x])))))

int
main(int argc, char *argv[])
{
  (void)argc;
  (void)argv;

  printf("\nHello World!\n");
  printf("%s:%d\n", __FILE__, __LINE__);

  DEBUG_PRINT("\n*** Development build\n");
  DEBUG_PRINT("Build: %s %s\n", __DATE__, __TIME__);

  return EXIT_SUCCESS;
}
