#!/usr/bin/env bash
set -eu

DEFAULT_SHELL=$(basename $SHELL)
BASEDIR=$(pwd)
SHELLCONF=""

# Aliases to be written to shell config:
ALIAS1="alias copy-vsctasks=\"$BASEDIR/copy_tasks.sh\""
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
  echo "*** Shell not found: exit"
  exit 0
fi

# Check if the aliases are already written to shell config:
if [[ $(grep $BASEDIR $SHELLCONF) ]]; then
  echo "*** Alias seems to be already applied to $SHELLCONF: exit"
  exit 0
fi

# Append aliases to shell config:
echo "*** Appending alias to $SHELLCONF"
echo >> $SHELLCONF
echo $ALIAS1 >> $SHELLCONF
echo $ALIAS2 >> $SHELLCONF
echo $ALIAS3 >> $SHELLCONF
echo $ALIAS4 >> $SHELLCONF
echo $ALIAS5 >> $SHELLCONF
echo "*** Please reload your shell: source $SHELLCONF"
