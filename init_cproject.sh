#!/usr/bin/env bash

if [ $# -eq 0 ]; then
  APP=my_app
else
  APP=$1
fi

BASEDIR=$(dirname "$0")
# echo "$BASEDIR"

SUPPORTED="2.28.0"
GIT_VERSION=$(git --version | cut -d' ' -f3)

# Initialize a git repo with an inital commit (git < 2.28.0 does not support 'git init -b <name>'):
GIT_INIT_REPO() {
  if (( $(echo "$GIT_VERSION $SUPPORTED" | awk '{print ($1 >= $2)}') )); then
    git init -b main &&
  else
    git init && git checkout -b main &&
  fi
  git add -A && git commit -m 'Initial commit'
}

echo "*** Initializing C project '$APP' in this folder"
echo

# Create a C project with vscode tasks in the current directory:
mkdir -p $APP && cp -r $BASEDIR/c_src/. ./$APP/ && mkdir -p ./$APP/.vscode &&
cp $BASEDIR/vscode/*.json ./$APP/.vscode/ &&
sed -i.bak "s/xxxxxxxxx/$APP/g" ./$APP/Makefile ./$APP/.gitignore &&
cd ./$APP/ && rm *.bak .*.bak &&
GIT_INIT_REPO && cd ..
code ./$APP &&

echo &&
echo "*** Done."
