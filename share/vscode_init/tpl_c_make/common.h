#pragma once

#ifdef __GNUC__
#define NOT_USED __attribute__((unused))
#else
#define NOT_USED
#endif

#define RED "\x1B[31m"
#define GRN "\x1B[32m"
#define YEL "\x1B[33m"
#define BLU "\x1B[34m"
#define MAG "\x1B[35m"
#define CYN "\x1B[36m"
#define WHT "\x1B[37m"
#define RESET "\x1B[0m"

#define PRINT_COLOR(color, format, ...) \
  printf(color format RESET "\n", ##__VA_ARGS__)
#define PRINT_RED(format, ...) PRINT_COLOR(RED, format, ##__VA_ARGS__)
#define PRINT_GREEN(format, ...) PRINT_COLOR(GRN, format, ##__VA_ARGS__)
#define PRINT_YELLOW(format, ...) PRINT_COLOR(YEL, format, ##__VA_ARGS__)
#define PRINT_BLUE(format, ...) PRINT_COLOR(BLU, format, ##__VA_ARGS__)
#define PRINT_MAGENTA(format, ...) PRINT_COLOR(MAG, format, ##__VA_ARGS__)
#define PRINT_CYAN(format, ...) PRINT_COLOR(CYN, format, ##__VA_ARGS__)
#define PRINT_WHITE(format, ...) PRINT_COLOR(WHT, format, ##__VA_ARGS__)

#if defined(__clang__) || defined(__GNUC__)
#define ATTRIBUTE_NO_SANITIZE_ADDRESS __attribute__((no_sanitize_address))
#else
#define ATTRIBUTE_NO_SANITIZE_ADDRESS
#endif

#ifndef ARRAY_SIZE
#define ARRAY_SIZE(x) (sizeof(x) / sizeof(0 [x]))
#endif

#ifdef DEBUG
#define DBUG(x) x
#else
#define DBUG(x)
#endif

#ifdef VERBOSE
#define VERB(x) x
#else
#define VERB(x)
#endif

#define print_debug(...) DBUG(printf(__VA_ARGS__))
#define print_verbose(...) VERB(printf(__VA_ARGS__))
