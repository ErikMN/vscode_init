#!/usr/bin/env bash
set -eu

# Print colors:
FMT_GREEN=$(printf '\033[32m')
FMT_BLUE=$(printf '\033[34m')
FMT_RESET=$(printf '\033[0m')

echo "${FMT_GREEN}*** Copying VSCode tasks to this folder${FMT_RESET}"
BASEDIR=$(dirname "$0")
VSCODE_TPL="tpl_vscode_make"
TEMPLATE="${TEMPLATE:-}"

# Set template from env:
if [ "$TEMPLATE" = cmeson ]; then
  echo "${FMT_BLUE}*** Using Meson VSCode template${FMT_RESET}"
  VSCODE_TPL="tpl_vscode_meson"
fi

mkdir -p .vscode && cp "$BASEDIR"/../share/vscode_init/$VSCODE_TPL/*.json ./.vscode/
