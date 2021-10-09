LDLIBS = -lm
# LDLIBS += `(pkg-config --libs mylib)`
# CFLAGS = `(pkg-config --cflags mylib)`
CC = gcc

PROGS = xxxxxxxxx

.PHONY: all debug prod dev clean

# CFLAGS += -Wall -Wextra -Wmaybe-uninitialized
# CFLAGS += -Wpedantic
CFLAGS += -Werror

# Building With Address Sanitzer:
# CFLAGS += -fsanitize=address -O1 -fno-omit-frame-pointer
# LDLIBS += -fsanitize=address

SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)

all: $(PROGS)

debug:
	@echo "*** Debug info:"
	@echo "Source-files:" $(SRCS)
	@echo "Object-files:" $(OBJS)

# Production flags:
# CFLAGS += -Wextra -Wmaybe-uninitialized -O3

# Development flags:
CFLAGS += -g -O0 -DDEV

# Standard target:
$(PROGS): $(OBJS)
	$(CC) $^ $(LDLIBS) -o $@

clean:
	$(RM) $(PROGS) $(OBJS)
