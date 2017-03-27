#!/bin/bash

DIR=$(cd $(dirname -- "$0") && pwd)
SRC_DIR="$DIR/src"

if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

for file in `ls "$SRC_DIR"`; do
    ln -sf "$SRC_DIR/$file" "$HOME/.$file"
done
