CC = g++
PROGS = xxxxxxxxx
LDFLAGS = -lm

# PKGS += mylib
ifdef PKGS
	LDLIBS += $(shell pkg-config --libs $(PKGS))
	CPPFLAGS += $(shell pkg-config --cflags $(PKGS))
endif

SRCS = $(wildcard *.cpp)
OBJS = $(SRCS:.cpp=.o)
CPPFLAGS += -Werror

ifeq ($(FINAL), y)
	CPPFLAGS += -DNDEBUG -O3
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

.PHONY: all debug clean
all: $(PROGS)

debug:
	@echo "*** Debug info:"
	@echo "Source-files:" $(SRCS)
	@echo "Object-files:" $(OBJS)
	@echo "Compiler-flags:" $(CPPFLAGS)

$(PROGS): $(OBJS)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

clean:
	$(RM) $(PROGS) $(OBJS)
