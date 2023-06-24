SCRIPTS_DIR := /usr/local/bin
SCRIPTS = \
	init_cproject.sh:create-c-app \
	init_cpp_project.sh:create-cpp-app \
	init_shared_lib_cproject.sh:create-shared-lib-c-app

VS_CODE_INIT_DIR := /usr/local/vscode_init

POST_INSTALL_SCRIPT = \
	sed -i 's/init_cproject.sh/create-c-app/g' "$(SCRIPTS_DIR)/create-cpp-app"; \
	sed -i 's/init_cproject.sh/create-c-app/g' "$(SCRIPTS_DIR)/create-shared-lib-c-app"; \
	sed -i 's/BASEDIR=$$(dirname "$$0")/BASEDIR=\/usr\/local/' "$(SCRIPTS_DIR)/create-c-app"

.PHONY: install uninstall help

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install     Install the scripts and vscode_init folder"
	@echo "  uninstall   Remove the installed scripts and vscode_init folder"
	@echo "  help        Show this help message"

install: uninstall
	@for script in $(SCRIPTS); do \
		src=$${script%%:*}; \
		dest=$${script#*:}; \
		echo "Installing $$src as $(SCRIPTS_DIR)/$$dest"; \
		cp "$$src" "$(SCRIPTS_DIR)/$$dest"; \
	done
	@echo "Installing vscode_init folder to $(VS_CODE_INIT_DIR)"; \
	cp -rn vscode_init "$(VS_CODE_INIT_DIR)"; \
	$(POST_INSTALL_SCRIPT)

uninstall:
	@for script in $(SCRIPTS); do \
		dest=$${script#*:}; \
		echo "Removing $(SCRIPTS_DIR)/$$dest"; \
		rm -f "$(SCRIPTS_DIR)/$$dest"; \
	done
	@echo "Removing $(VS_CODE_INIT_DIR)"; \
	rm -rf "$(VS_CODE_INIT_DIR)"

.DEFAULT_GOAL := help
