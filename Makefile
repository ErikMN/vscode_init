INSTALL_DIR := /usr/local

SCRIPTS_INST_DIR := $(INSTALL_DIR)/bin
VS_CODE_INIT_INST_DIR := $(INSTALL_DIR)/share/vscode_init

SCRIPTS := $(wildcard bin/*)
VSCODE_INIT := $(wildcard share/vscode_init/*)

.DEFAULT_GOAL := help
.PHONY: install uninstall help

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install     Install the scripts and vscode_init folder"
	@echo "  uninstall   Remove the installed scripts and vscode_init folder"
	@echo "  help        Show this help message"

install:
	@mkdir -p "$(SCRIPTS_INST_DIR)"
	@for script in $(SCRIPTS); do \
		echo "Installing $(SCRIPTS_INST_DIR)/$$(basename $$script)"; \
		cp "$$script" "$(SCRIPTS_INST_DIR)/$$(basename $$script)"; \
	done
	@echo "Installing $(VS_CODE_INIT_INST_DIR)"; \
	mkdir -p "$(VS_CODE_INIT_INST_DIR)"; \
	cp -r $(VSCODE_INIT) "$(VS_CODE_INIT_INST_DIR)"

uninstall:
	@for script in $(SCRIPTS); do \
		echo "Removing $(SCRIPTS_INST_DIR)/$$(basename $$script)"; \
		rm -f "$(SCRIPTS_INST_DIR)/$$(basename $$script)"; \
	done
	@echo "Removing $(VS_CODE_INIT_INST_DIR)"; \
	rm -rf "$(VS_CODE_INIT_INST_DIR)"
