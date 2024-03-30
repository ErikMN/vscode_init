#!/usr/bin/env bash
set -eu

# Print colors:
FMT_RED=$(printf '\033[31m')
FMT_GREEN=$(printf '\033[32m')
FMT_BOLD=$(printf '\033[1m')
FMT_RESET=$(printf '\033[0m')

DEFAULT_SHELL=$(basename "$SHELL")
BASEDIR=$(pwd)
SHELLCONF=""

# Aliases to be written to shell config:
ALIAS1="alias copy-vsctasks=\"$BASEDIR/utils/copy_tasks.sh\""
ALIAS2="alias create-c-app=\"$BASEDIR/bin/create-c-app\""
ALIAS3="alias create-cpp-app=\"$BASEDIR/bin/create-cpp-app\""
ALIAS4="alias create-shared-lib-c-app=\"$BASEDIR/bin/create-shared-lib-c-app\""
ALIAS5="alias create-c-meson-app=\"$BASEDIR/bin/create-c-meson-app\""

# Set shell configuration to use:
if [ "$DEFAULT_SHELL" = "zsh" ]; then
  SHELLCONF=$HOME/.zshrc
elif [ "$DEFAULT_SHELL" = "bash" ]; then
  SHELLCONF=$HOME/.bashrc
else
  echo "${FMT_RED}*** Shell not found: exit${FMT_RESET}"
  exit 0
fi

# Check if the aliases are already written to shell config:
if grep -q "$BASEDIR" "$SHELLCONF"; then
  echo "${FMT_RED}*** Alias seems to be already applied to $SHELLCONF: exit${FMT_RESET}"
  exit 0
fi

# Append aliases to shell config:
echo "${FMT_GREEN}*** Appending alias to $SHELLCONF${FMT_RESET}"
{
  echo
  echo "# VSCode init aliases:"
  echo "$ALIAS1"
  echo "$ALIAS2"
  echo "$ALIAS3"
  echo "$ALIAS4"
  echo "$ALIAS5"
} >>"$SHELLCONF"

echo "${FMT_BOLD}*** Please reload your shell: source $SHELLCONF${FMT_RESET}"
