#!/usr/bin/env bash
set -eu

BASEDIR=$(pwd)

#==============================================================================#
# Helpers:

# Print colors:
FMT_GREEN=$(printf '\033[32m')
FMT_YELLOW=$(printf '\033[33m')
FMT_RED=$(printf '\033[31m')
FMT_BLUE=$(printf '\033[34m')
FMT_RESET=$(printf '\033[0m')

display_time() {
  local milliseconds="$1"
  local seconds=$((milliseconds / 1000))
  local milliseconds=$((milliseconds % 1000))
  printf "%02d:%02d:%02d.%03d" "$((seconds / 3600))" "$((seconds % 3600 / 60))" "$((seconds % 60))" "$milliseconds"
}

display_start_time() {
  start_time=$(date +%s%N)
  echo "${FMT_BLUE}*** Start test at $(date +"%T.%3N")${FMT_RESET}"
}

display_end_time() {
  end_time=$(date +%s%N)
  elapsed_nanoseconds=$((end_time - start_time))
  elapsed_milliseconds=$((elapsed_nanoseconds / 1000000))
  echo
  echo "${FMT_GREEN}*** End test OK at $(date +"%T.%3N") Elapsed time: $(display_time $elapsed_milliseconds)${FMT_RESET}"
  echo
}

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

echo "${FMT_GREEN}*** Start test $(basename "$0")${FMT_RESET}"
echo "${FMT_BLUE}*** BASEDIR: $BASEDIR${FMT_RESET}"
echo

display_start_time

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

cd "$BASEDIR"/build && "$BASEDIR"/utils/copy_tasks.sh && cd "$BASEDIR"

#==============================================================================#
# Uninstall vscode_init:

make uninstall PREFIX="$BASEDIR"/build

check_exit_status
display_end_time

#==============================================================================#
