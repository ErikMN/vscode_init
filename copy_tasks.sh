#!/usr/bin/env bash

echo "*** Copying VSCode tasks to this folder"
BASEDIR=$(dirname $0)
VSCODE_TPL="tpl_vscode_make"
mkdir -p .vscode && cp $BASEDIR/share/vscode_init/$VSCODE_TPL/*.json ./.vscode/
