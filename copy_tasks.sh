#!/usr/bin/env bash

BASEDIR=$(dirname "$0")
# echo "$BASEDIR"

echo '*** Copying VSCode tasks to this folder'

# Create a .vscode dir in the project root and copy the task.json and launch.json to it
mkdir -p .vscode && cp $BASEDIR/vscode/*.json ./.vscode/
