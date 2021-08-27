#!/usr/bin/env bash

if [ $# -eq 0 ]; then
  APP=my_app
else
  APP=$1
fi

BASEDIR=$(dirname "$0")
# echo "$BASEDIR"

echo "*** Initializing C project '$APP' in this folder"
echo

# Create a C project with vscode tasks in the current directory:
mkdir -p $APP && cp -r $BASEDIR/c_src/. ./$APP/ && mkdir -p ./$APP/.vscode &&
cp $BASEDIR/vscode/*.json ./$APP/.vscode/ &&
sed -i "s/xxxxxxxxx/$APP/g" ./$APP/Makefile ./$APP/.gitignore &&
cd ./$APP/ && git init && git add -A && git commit -m 'Initial commit' && cd .. &&
code ./$APP &&

echo &&
echo "*** Done."
