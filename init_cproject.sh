#!/usr/bin/env bash
set -e

if [ $# -eq 0 ]; then
  APP=my_app
else
  APP=$1
fi

# Set TEMPLATE=cpp to use the C++ template:
if [[ -z ${TEMPLATE} ]]; then
  PROJECT_TO_USE=C
  TEMPLATE_DIR=c_src
else
  if [ $TEMPLATE = cpp ]; then
    PROJECT_TO_USE=C++
    TEMPLATE_DIR=cpp_src
  fi
fi

VSCODE="command -v code >/dev/null 2>&1"
GIT="command -v git >/dev/null 2>&1"

BASEDIR=$(dirname $0)
DIR=$(dirname ${APP})
APP=$(basename ${APP})
PWD=$(pwd)

if [ -d $DIR/$APP ]; then
  echo "*** Error: '$APP' already exists... exit"
  return
fi

SUPPORTED="2.28.0"
GIT_VERSION=$(git --version | cut -d' ' -f3)

# Silence git:
q_git() {
  git "$@" >/dev/null
}

# Initialize a git repo with an inital commit (git < 2.28.0 does not support 'git init -b <name>'):
GIT_INIT_REPO() {
  if ! eval $GIT; then
    echo "*** Git is not installed"
    return
  fi

  if (( $(echo $GIT_VERSION $SUPPORTED | awk '{print ($1 >= $2)}') )); then
    q_git init -b main
  else
    q_git init && q_git checkout -b main
  fi
  q_git add -A && q_git commit -m "Initial commit"
}

# Create a C project with vscode tasks in the provided directory:
SETUP_PROJECT() {
  echo "*** Initializing $PROJECT_TO_USE project '$APP' in this folder"

  mkdir -p $DIR/$APP &&
  cp -r $BASEDIR/$TEMPLATE_DIR/. $DIR/$APP/ &&
  mkdir -p $DIR/$APP/.vscode &&
  cp $BASEDIR/vscode/*.json $DIR/$APP/.vscode/ &&
  sed -i.bak "s/xxxxxxxxx/$APP/g" $DIR/$APP/Makefile $DIR/$APP/.gitignore &&
  cd $DIR/$APP/ &&
  rm *.bak .*.bak &&
  GIT_INIT_REPO
}

# Start Visual Studio Code if it is installed:
START_VSCODE() {
  if eval $VSCODE; then
    code $PWD
  else
    echo "*** Visual Studio Code is not installed"
  fi
}

# Execute setup functions:
SETUP_PROJECT
START_VSCODE

echo "*** Done."
