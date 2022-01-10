LDLIBS = -lm
# LDLIBS += `(pkg-config --libs mylib)`
# CPPFLAGS = `(pkg-config --cflags mylib)`
CC = g++

PROGS = xxxxxxxxx

.PHONY: all debug prod dev clean

# CPPFLAGS += -Wall -Wextra -Wmaybe-uninitialized
# CPPFLAGS += -Wpedantic
CPPFLAGS += -Werror

# Building With Address Sanitzer:
# CPPFLAGS += -fsanitize=address -O1 -fno-omit-frame-pointer
# LDLIBS += -fsanitize=address

SRCS = $(wildcard *.cpp)
OBJS = $(SRCS:.cpp=.o)

all: $(PROGS)

debug:
	@echo "*** Debug info:"
	@echo "Source-files:" $(SRCS)
	@echo "Object-files:" $(OBJS)

# Production flags:
# CPPFLAGS += -Wextra -Wmaybe-uninitialized -O3

# Development flags:
CPPFLAGS += -g -O0 -DDEV

# Standard target:
$(PROGS): $(OBJS)
	$(CC) $^ $(LDLIBS) -o $@

clean:
	$(RM) $(PROGS) $(OBJS)
