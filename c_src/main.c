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

int
main(int argc, char *argv[])
{
  printf("\nHello World!\n");
  printf("%s:%d\n", __FILE__, __LINE__);

#ifdef DEV
  printf("\n*** Development build\n");
  printf("Build: %s %s\n", __DATE__, __TIME__);
#endif

  return EXIT_SUCCESS;
}
