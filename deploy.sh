#!/bin/bash

DIR=$(cd $(dirname -- "$0") && pwd)
SRC_DIR="$DIR/src"

for file in `ls "$SRC_DIR"`; do
    ln -sf "$SRC_DIR/$file" "$HOME/.$file"
done
