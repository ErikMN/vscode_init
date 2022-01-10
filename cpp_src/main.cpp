/**
 * https://en.cppreference.com/w/cpp/header
 */
#include <iostream>
#include <iomanip>
#include <string>
#include <array>
#include <vector>
#include <map>
#include <cassert>
#include <cstdint>
#include <climits>
#include <cerrno>
#include <getopt.h>
#include <sys/types.h>
#include <sys/stat.h>

using namespace std;

int
main(int argc, char *argv[])
{
  cout << endl << "Hello World" << endl;
  cout << __FILE__ << ":" << __LINE__ << endl;

#ifdef DEV
  cout << endl << "*** Development build" << endl;
  cout << "Build: " << __DATE__ << " " << __TIME__ << endl;
#endif

  return EXIT_SUCCESS;
}
