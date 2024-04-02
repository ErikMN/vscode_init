#!/usr/bin/env bash
set -eu

echo "*** Start test"

BASEDIR=$(pwd)

echo $BASEDIR

rm -rf build
mkdir build

make install PREFIX=$BASEDIR/build

export DEBUG=true
export VSC=false

$BASEDIR/build/bin/create-c-app $BASEDIR/build/test1
cd $BASEDIR/build/test1 && make run && cd $BASEDIR

$BASEDIR/build/bin/create-cpp-app $BASEDIR/build/test2
cd $BASEDIR/build/test2 && make run && cd $BASEDIR

$BASEDIR/build/bin/create-shared-lib-c-app $BASEDIR/build/test3
cd $BASEDIR/build/test3 && make run && cd $BASEDIR

$BASEDIR/build/bin/create-c-meson-app $BASEDIR/build/test4
cd $BASEDIR/build/test4 && make run && cd $BASEDIR

make uninstall PREFIX=$BASEDIR/build

echo
echo "*** Done. Result:" $?
echo
