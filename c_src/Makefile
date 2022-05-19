CC = gcc
PROGS = xxxxxxxxx
LDLIBS = -lm

# PKGS += mylib
ifdef PKGS
	LDLIBS += $(shell pkg-config --libs $(PKGS))
	CFLAGS += $(shell pkg-config --cflags $(PKGS))
endif

SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)
CFLAGS += -Werror
# CFLAGS += -std=c99

# FINAL=y
ifeq ($(FINAL), y)
	LDFLAGS += -s
	CFLAGS += -DNDEBUG -g0 -O2
	CFLAGS += -Wpedantic -Wextra -Wmaybe-uninitialized
	CFLAGS += -W -Wformat=2 -Wpointer-arith -Wbad-function-cast
	CFLAGS += -Wstrict-prototypes -Wmissing-prototypes -Winline
	CFLAGS += -Wdisabled-optimization -Wfloat-equal -Wall
else
	# ASAN=y
	CFLAGS += -g3 -DDEBUG
	ifeq ($(ASAN), y)
		CFLAGS += -fsanitize=address -O1 -fno-omit-frame-pointer
		LDLIBS += -fsanitize=address
	endif
endif

.PHONY: all debug run cppcheck indent clean
all: $(PROGS)

debug:
	@echo "*** Debug info:"
	@echo "Source-files:" $(SRCS)
	@echo "Object-files:" $(OBJS)
	@echo "Compiler-flags:" $(CFLAGS)

$(PROGS): $(OBJS)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

run: $(PROGS)
	@./$(PROGS)

cppcheck:
	@echo "*** Static code analysis"
	@cppcheck $(shell find . -name "*.[ch]") \
		--verbose --enable=all -DDEBUG=1 \
		--suppress=missingIncludeSystem \
		--suppress=unknownMacro \
		--suppress=unusedFunction

indent:
	@echo "*** Formatting code"
	@clang-format $(shell find . -name "*.[ch]") \
		-style=file -i -fallback-style=none

clean:
	$(RM) $(PROGS) $(OBJS)
