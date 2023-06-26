INSTALL_DIR := /usr/local
SCRIPTS_DIR := $(INSTALL_DIR)/bin
SCRIPTS = \
	init_cproject.sh:create-c-app \
	init_cpp_project.sh:create-cpp-app \
	init_shared_lib_cproject.sh:create-shared-lib-c-app

VS_CODE_INIT_DIR := $(INSTALL_DIR)/vscode_init

# HACK: to make it work on both GNU and BSD sed:
POST_INSTALL_SCRIPT = \
	sed -i'.orig' -e 's/init_cproject.sh/create-c-app/g' "$(SCRIPTS_DIR)/create-cpp-app"; \
	rm -f "$(SCRIPTS_DIR)/create-cpp-app.orig"; \
	sed -i'.orig' -e 's/init_cproject.sh/create-c-app/g' "$(SCRIPTS_DIR)/create-shared-lib-c-app"; \
	rm -f "$(SCRIPTS_DIR)/create-shared-lib-c-app.orig"; \
	sed -i'.orig' -e 's|BASEDIR=$$(dirname "$$0")|BASEDIR=$(INSTALL_DIR)|' "$(SCRIPTS_DIR)/create-c-app"; \
	rm -f "$(SCRIPTS_DIR)/create-c-app.orig"

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
	@mkdir -p "$(SCRIPTS_DIR)"
	@for script in $(SCRIPTS); do \
		src=$${script%%:*}; \
		dest=$${script#*:}; \
		echo "Installing $$src as $(SCRIPTS_DIR)/$$dest"; \
		cp "$$src" "$(SCRIPTS_DIR)/$$dest"; \
	done
	@echo "Installing vscode_init folder to $(INSTALL_DIR)"; \
	cp -r vscode_init "$(INSTALL_DIR)"; \
	$(POST_INSTALL_SCRIPT)

uninstall:
	@for script in $(SCRIPTS); do \
		dest=$${script#*:}; \
		echo "Removing $(SCRIPTS_DIR)/$$dest"; \
		rm -f "$(SCRIPTS_DIR)/$$dest"; \
	done
	@echo "Removing $(VS_CODE_INIT_DIR)"; \
	rm -rf "$(VS_CODE_INIT_DIR)"
