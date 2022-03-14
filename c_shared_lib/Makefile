CC = gcc
PROGS = xxxxxxxxx
LDFLAGS = -lm

# PKGS += mylib
ifdef PKGS
	LDLIBS += $(shell pkg-config --libs $(PKGS))
	CFLAGS += $(shell pkg-config --cflags $(PKGS))
endif

SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)
CFLAGS += -Werror -std=c99

LIB_DIR = my_lib
LIB_TARGET = $(LIB_DIR)/lib$(PROGS).so
LIB_SRCS = $(wildcard $(LIB_DIR)/*.c)
LIB_OBJ = $(LIB_SRCS:.c=.o)
LIB_LDFLAGS = -lm -shared

LIB_PATH = $(shell pwd)/$(LIB_DIR)
LDFLAGS += -L$(LIB_PATH)

# FINAL=y
ifeq ($(FINAL), y)
	LDFLAGS += -s
	CFLAGS += -DNDEBUG -g0 -O2
	CFLAGS += -Wpedantic -Wextra -Wmaybe-uninitialized
	CFLAGS += -W -Wformat=2 -Wpointer-arith -Wbad-function-cast
	CFLAGS += -Wstrict-prototypes -Wmissing-prototypes -Winline
	CFLAGS += -Wdisabled-optimization -Wfloat-equal -Wall
else
	CFLAGS += -g3 -DDEBUG
	ifeq ($(ASAN), y)
		CFLAGS += -fsanitize=address -O1 -fno-omit-frame-pointer
		LDLIBS += -fsanitize=address
	endif
endif

.PHONY: all debug clean run $(LIB_TARGET) $(PROGS)
all: $(LIB_TARGET) $(PROGS)

debug:
	@echo "*** Debug info:"
	@echo "Source-files:" $(SRCS)
	@echo "Object-files:" $(OBJS)
	@echo "Compiler-flags:" $(CFLAGS)
	@echo "Linker-flags:" $(LDFLAGS)
	@echo "Linker-libs:" $(LDLIBS)
	@echo "Lib-src:" $(LIB_SRCS)
	@echo "Lib-objs:" $(LIB_OBJ)

$(LIB_TARGET): $(LIB_OBJ)
	$(CC) -fPIC $(LIB_LDFLAGS) $^ $(LDLIBS) -o $@

$(PROGS): $(OBJS) $(LIB_TARGET)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@ -l$(PROGS)

run: $(PROGS)
	@LD_LIBRARY_PATH=$(LIB_PATH) ./$(PROGS)

clean:
	$(RM) $(PROGS) $(OBJS) $(LIB_TARGET) $(LIB_OBJ)
