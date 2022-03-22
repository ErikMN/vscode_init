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
	CPPFLAGS += -g3 -DDEBUG
	ifeq ($(ASAN), y)
		CPPFLAGS += -fsanitize=address -O1 -fno-omit-frame-pointer
		LDLIBS += -fsanitize=address
	endif
endif

.PHONY: all debug run clean
all: $(PROGS)

debug:
	@echo "*** Debug info:"
	@echo "Source-files:" $(SRCS)
	@echo "Object-files:" $(OBJS)
	@echo "Compiler-flags:" $(CPPFLAGS)

$(PROGS): $(OBJS)
	$(CC) $^ $(LDLIBS) -o $@ $(LDFLAGS)

run: $(PROGS)
	@./$(PROGS)

clean:
	$(RM) $(PROGS) $(OBJS)
