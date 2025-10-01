#!/usr/bin/env bash
set -eu

BASEDIR=$(pwd)
BUILD=build
BUILDDIR="$BASEDIR"/$BUILD

#==============================================================================#
# Helpers:

OS=$(uname)

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
  if [ "$OS" = "Darwin" ]; then
    echo "${FMT_GREEN}*** End test OK at $(date +"%T")${FMT_RESET}"
    return
  fi
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

export PREFIX="$BUILDDIR"

echo "${FMT_GREEN}*** Start test $(basename "$0")${FMT_RESET}"
echo "${FMT_BLUE}*** BASEDIR: $BASEDIR${FMT_RESET}"
echo

display_start_time

rm -rf build
mkdir build

make install

check_exit_status

#==============================================================================#
# Setup test projects:

export DEBUG=true
export VSC=false

"$BUILDDIR"/bin/create-c-app "$BUILDDIR"/test1
cd "$BUILDDIR"/test1 && make run && show_git_log "$(pwd)" && cd "$BASEDIR"

"$BUILDDIR"/bin/create-cpp-app "$BUILDDIR"/test2
cd "$BUILDDIR"/test2 && make run && show_git_log "$(pwd)" && cd "$BASEDIR"

"$BUILDDIR"/bin/create-shared-lib-c-app "$BUILDDIR"/test3
cd "$BUILDDIR"/test3 && make run && show_git_log "$(pwd)" && cd "$BASEDIR"

if check_command "meson"; then
  "$BUILDDIR"/bin/create-c-meson-app "$BUILDDIR"/test4
  cd "$BUILDDIR"/test4 && make run && show_git_log "$(pwd)" && cd "$BASEDIR"
fi

cd "$BUILDDIR" && "$BASEDIR"/utils/copy_tasks.sh && cd "$BASEDIR"

#==============================================================================#
# Uninstall vscode_init:

make uninstall

check_exit_status
display_end_time

#==============================================================================#
# Test version_ge helper:

version_ge() {
  local i
  local v1 v2
  IFS=. read -ra v1 <<<"$1"
  IFS=. read -ra v2 <<<"$2"
  for ((i = 0; i < ${#v1[@]} || i < ${#v2[@]}; i++)); do
    local n1=${v1[i]:-0}
    local n2=${v2[i]:-0}
    if ((10#$n1 > 10#$n2)); then return 0; fi
    if ((10#$n1 < 10#$n2)); then return 1; fi
  done
  return 0
}

test_version_ge() {
  echo "${FMT_BLUE}*** Running version_ge tests${FMT_RESET}"
  run_test() {
    local s1=$1 s2=$2 expected=$3
    local result
    if version_ge "$s1" "$s2"; then
      result=0
    else
      result=1
    fi
    if [ "$result" -eq "$expected" ]; then
      echo "${FMT_GREEN}PASS:${FMT_RESET} version_ge $s1 >= $s2"
    else
      echo "${FMT_RED}FAIL:${FMT_RESET} version_ge $s1 >= $s2 (expected $expected got $result)"
      exit 1
    fi
  }
  # Format: v1 v2 expected_result(0=success,1=failure)
  run_test "2.28.0" "2.28.0" 0 # equal
  run_test "2.29.0" "2.28.0" 0 # greater
  run_test "2.28.1" "2.28.0" 0 # patch greater
  run_test "2.28.0" "2.29.0" 1 # less
  run_test "2.7" "2.28.0" 1    # much less
  run_test "2.28" "2.28.0" 0   # equal with missing segment
  run_test "10.0.1" "9.9.9" 0  # big jump

  echo "${FMT_GREEN}*** version_ge tests passed${FMT_RESET}"
  echo
}
test_version_ge

#==============================================================================#
