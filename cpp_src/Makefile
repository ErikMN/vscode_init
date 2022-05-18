CC = g++
PROGS = xxxxxxxxx
LDLIBS = -lm

# PKGS += mylib
ifdef PKGS
	LDLIBS += $(shell pkg-config --libs $(PKGS))
	CPPFLAGS += $(shell pkg-config --cflags $(PKGS))
endif

SRCS = $(wildcard *.cpp)
OBJS = $(SRCS:.cpp=.o)
CPPFLAGS += -Werror

# FINAL=y
ifeq ($(FINAL), y)
	LDFLAGS += -s
	CFLAGS += -DNDEBUG -g0 -O2
	CPPFLAGS += -Wpedantic -Wextra -Wmaybe-uninitialized
	CPPFLAGS += -W -Wformat=2 -Wpointer-arith -Winline
	CPPFLAGS += -Wdisabled-optimization -Wfloat-equal -Wall
else
	# ASAN=y
	CPPFLAGS += -g3 -DDEBUG
	ifeq ($(ASAN), y)
		CPPFLAGS += -fsanitize=address -O1 -fno-omit-frame-pointer
		LDLIBS += -fsanitize=address
	endif
endif

.PHONY: all debug run cppcheck indent clean
all: $(PROGS)

debug:
	@echo "*** Debug info:"
	@echo "Source-files:" $(SRCS)
	@echo "Object-files:" $(OBJS)
	@echo "Compiler-flags:" $(CPPFLAGS)

$(PROGS): $(OBJS)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

run: $(PROGS)
	@./$(PROGS)

cppcheck:
	@echo "*** Static code analysis"
	@find . -name "*.[ch]" | xargs cppcheck \
		--error-exitcode=1 --verbose --enable=all --suppress=missingIncludeSystem

indent:
	@echo "*** Formatting code"
	@find . -name "*.[ch]" | xargs clang-format \
		-style=file -i -fallback-style=none

clean:
	$(RM) $(PROGS) $(OBJS)
