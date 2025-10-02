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
#include "common.h"

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
