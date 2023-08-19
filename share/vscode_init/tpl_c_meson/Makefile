BUILD_ROOT=builddir

.PHONY: all
all: meson

.PHONY: setup
setup $(BUILD_ROOT):
	@echo "*** Setup project using Meson"
	@meson $(BUILD_ROOT)

.PHONY: meson
meson: $(BUILD_ROOT)
	@echo "*** Build project using Meson"
	@meson compile -C $(BUILD_ROOT)

.PHONY: run
run: meson
	@./$(BUILD_ROOT)/xxxxxxxxx

.PHONY: cppcheck
cppcheck:
	@echo "*** Static code analysis"
	@cppcheck $(shell find . -name "*.[ch]") \
		--verbose --enable=all -DDEBUG=1 \
		--suppress=missingIncludeSystem \
		--suppress=unknownMacro \
		--suppress=unusedFunction

.PHONY: indent
indent:
	@echo "*** Formatting code"
	@clang-format $(shell find . -name "*.[ch]") \
		-style=file -i -fallback-style=none

.PHONY: clean
clean:
	@meson compile -C $(BUILD_ROOT) --clean

.PHONY: distclean
distclean:
	$(RM) -r $(BUILD_ROOT)
