#!/bin/bash

BASEDIR=$(dirname "$0")
mkdir -p "$1/build"
touch "$1/build/.gdignore"
rsync -rc --delete "$BASEDIR/gdscript" "$1"
rsync -rc --delete "$BASEDIR/script" "$1/build"
rsync -rc --delete "$BASEDIR/prefab" "$1/build"
