INSTALL_DIR := /usr/local

SCRIPTS_INST_DIR := $(INSTALL_DIR)/bin
VS_CODE_INIT_INST_DIR := $(INSTALL_DIR)/share/vscode_init

SCRIPTS := $(wildcard bin/*)
VSCODE_INIT := $(wildcard share/vscode_init/*)
CHECK := $(shell command -v shellcheck 2> /dev/null)

.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install     Install the scripts and vscode_init folder to $(INSTALL_DIR)"
	@echo "  uninstall   Remove the installed scripts and vscode_init folder"
	@echo "  append      Append aliases to shell profile for local install"
	@echo "  update      Update the repo (git required)"
	@echo "  lint        Lint all scripts using shellcheck"
	@echo "  help        Show this help message"

.PHONY: check
check:
ifndef CHECK
	@echo "*** Please install shellcheck first"
	@exit 1
endif

.PHONY: update
update:
	@git pull --rebase --autostash

.PHONY: lint
lint: check
	@shellcheck */*.sh

.PHONY: append
append:
	@./utils/append_alias.sh

.PHONY: check_root_access
check_root_access:
	@if [ ! -w "$(INSTALL_DIR)" ]; then \
		echo "Error: $(INSTALL_DIR) requires root access to write to."; \
		exit 1; \
	fi

.PHONY: install
install: check_root_access uninstall
	@mkdir -p "$(SCRIPTS_INST_DIR)"
	@for script in $(SCRIPTS); do \
		echo "Installing $(SCRIPTS_INST_DIR)/$$(basename $$script)"; \
		cp "$$script" "$(SCRIPTS_INST_DIR)/$$(basename $$script)"; \
	done
	@echo "Installing $(VS_CODE_INIT_INST_DIR)"; \
	mkdir -p "$(VS_CODE_INIT_INST_DIR)"; \
	cp -r $(VSCODE_INIT) "$(VS_CODE_INIT_INST_DIR)"

.PHONY: uninstall
uninstall: check_root_access
	@for script in $(SCRIPTS); do \
		echo "Removing $(SCRIPTS_INST_DIR)/$$(basename $$script)"; \
		rm -f "$(SCRIPTS_INST_DIR)/$$(basename $$script)"; \
	done
	@echo "Removing $(VS_CODE_INIT_INST_DIR)"; \
	rm -rf "$(VS_CODE_INIT_INST_DIR)"
