#!/usr/bin/env bash

echo "*** Copying VSCode tasks to this folder"
BASEDIR=$(dirname $0)
mkdir -p .vscode && cp $BASEDIR/vscode_init/vscode/*.json ./.vscode/
