#!/usr/bin/env bash
set -eu

#==============================================================================#
# Helpers:

# Print colors:
FMT_GREEN=$(printf '\033[32m')
FMT_YELLOW=$(printf '\033[33m')
FMT_RED=$(printf '\033[31m')
FMT_RESET=$(printf '\033[0m')

show_git_log() {
  local dir=$1
  if command -v git >/dev/null 2>&1; then
    echo "${FMT_YELLOW}*** Git log for $dir:${FMT_RESET}"
    (git -C "$dir" log | cat)
  fi
}

check_exit_status() {
  local exit_status=$?
  if [ $exit_status -ne 0 ]; then
    echo "${FMT_RED}Error: The last command exited with status $exit_status${FMT_RESET}" >&2
    exit $exit_status
  fi
}

check_command() {
  if ! command -v "$1" &>/dev/null; then
    if [[ -n "${2-}" && "$2" == "exit" ]]; then
      echo "${FMT_RED}Error: '$1' command not found: exit${FMT_RESET}"
      exit 1
    fi
    echo "${FMT_YELLOW}Warning: '$1' command not found.${FMT_RESET}"
    return 1
  fi
}

#==============================================================================#
# Check prerequisites:

check_command make "exit"

#==============================================================================#
# Setup test and install vscode_init locally:

echo "${FMT_GREEN}*** Start test${FMT_RESET}"

BASEDIR=$(pwd)

echo "${FMT_GREEN}$BASEDIR${FMT_RESET}"

rm -rf build
mkdir build

make install PREFIX="$BASEDIR"/build

check_exit_status

#==============================================================================#
# Setup test projects:

export DEBUG=true
export VSC=false

"$BASEDIR"/build/bin/create-c-app "$BASEDIR"/build/test1
cd "$BASEDIR"/build/test1 && make run && show_git_log "$(pwd)" && cd "$BASEDIR"

"$BASEDIR"/build/bin/create-cpp-app "$BASEDIR"/build/test2
cd "$BASEDIR"/build/test2 && make run && show_git_log "$(pwd)" && cd "$BASEDIR"

"$BASEDIR"/build/bin/create-shared-lib-c-app "$BASEDIR"/build/test3
cd "$BASEDIR"/build/test3 && make run && show_git_log "$(pwd)" && cd "$BASEDIR"

if check_command "meson"; then
  "$BASEDIR"/build/bin/create-c-meson-app "$BASEDIR"/build/test4
  cd "$BASEDIR"/build/test4 && make run && show_git_log "$(pwd)" && cd "$BASEDIR"
fi

#==============================================================================#
# Uninstall vscode_init:

make uninstall PREFIX="$BASEDIR"/build

check_exit_status

echo
echo "${FMT_GREEN}*** Done.${FMT_RESET}"
echo

#==============================================================================#
