# Default installation directory:
PREFIX ?= /usr/local

# Installation directories:
INSTALL_DIR := $(PREFIX)
SCRIPTS_INST_DIR := $(INSTALL_DIR)/bin
VS_CODE_INIT_SHARE := $(INSTALL_DIR)/share
VS_CODE_INIT_INST_DIR := $(VS_CODE_INIT_SHARE)/vscode_init

# Scripts and vscode_init folder:
SCRIPTS := $(wildcard bin/*)
VSCODE_INIT := $(wildcard share/vscode_init/*)

.DEFAULT_GOAL := help

# Provide information on available targets:
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
	@echo "  test        Test the scripts"
	@echo "  help        Show this help message"

# Check if shellcheck is installed:
.PHONY: check
check:
	@command -v shellcheck >/dev/null 2>&1 || { \
		echo >&2 "*** Please install shellcheck first"; \
		exit 1; \
	}

# Check if git is installed:
.PHONY: check_git
check_git:
	@command -v git >/dev/null 2>&1 || { \
		echo >&2 "*** Please install git first"; \
		exit 1; \
	}

# Update the repository:
.PHONY: update
update: check_git
	@git pull --rebase --autostash

# Lint scripts using shellcheck:
.PHONY: lint
lint: check
	@shellcheck */*.sh

# Append aliases to shell profile for local install:
.PHONY: append
append:
	@./utils/append_alias.sh

# Test the scripts:
.PHONY: test
test:
	@./test/test_vscode_init.sh

# Check root access before installation or uninstallation:
.PHONY: check_root_access
check_root_access:
	@if [ ! -w "$(INSTALL_DIR)" ]; then \
		echo "Error: $(INSTALL_DIR) requires root access to write to."; \
		exit 1; \
	fi

# Install scripts and vscode_init folder:
.PHONY: install
install: check_root_access uninstall
	@echo "Creating directory: $(SCRIPTS_INST_DIR)"
	@install -d "$(SCRIPTS_INST_DIR)"
	@for script in $(SCRIPTS); do \
		echo "Installing $(SCRIPTS_INST_DIR)/$$(basename $$script)"; \
		install -m 755 "$$script" "$(SCRIPTS_INST_DIR)/$$(basename $$script)"; \
	done
	@echo "Installing to $(VS_CODE_INIT_INST_DIR)"; \
	install -d "$(VS_CODE_INIT_INST_DIR)"; \
	cp -r $(VSCODE_INIT) "$(VS_CODE_INIT_INST_DIR)"

# Remove installed scripts and vscode_init folder:
.PHONY: uninstall
uninstall: check_root_access
	@for script in $(SCRIPTS); do \
		echo "Removing $(SCRIPTS_INST_DIR)/$$(basename $$script)"; \
		rm -f "$(SCRIPTS_INST_DIR)/$$(basename $$script)"; \
	done
	@echo "Removing $(VS_CODE_INIT_INST_DIR)"; \
	rm -rf "$(VS_CODE_INIT_INST_DIR)"

	@if [ -d "$(SCRIPTS_INST_DIR)" ] && [ -z "$$(ls -A "$(SCRIPTS_INST_DIR)")" ]; then \
		echo "Removing empty directory: $(SCRIPTS_INST_DIR)"; \
		rmdir "$(SCRIPTS_INST_DIR)"; \
	fi
	@if [ -d "$(VS_CODE_INIT_SHARE)" ] && [ -z "$$(ls -A "$(VS_CODE_INIT_SHARE)")" ]; then \
		echo "Removing empty directory: $(VS_CODE_INIT_SHARE)"; \
		rmdir "$(VS_CODE_INIT_SHARE)"; \
	fi

# Clean test artifacts:
.PHONY: clean
clean:
	$(RM) -r build
