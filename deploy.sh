#!/bin/bash

DIR=$(cd "$(dirname -- "$0")" && pwd)
SRC_DIR="$DIR/src"

# update submodule

cd "$DIR"
git submodule init
git submodule update

# install

for fpath in `find "$SRC_DIR" -maxdepth 1 -type f`; do
    fname=`basename "$fpath"`
    ln -sf "$fpath" "$HOME/.$fname"
done

# set git pager

GIT_CFG="$HOME/.gitconfig.local"
GIT_PAGER="\"$SRC_DIR/diff-so-fancy/diff-so-fancy\" | less --tabs=4 -RFX"

if [ "`git config -f "$GIT_CFG" --get core.pager`" != "$GIT_PAGER" ]; then
    git config -f "$GIT_CFG" --unset-all core.pager
    git config -f "$GIT_CFG" --add core.pager "$GIT_PAGER"
fi

# set up autojump

cd $SRC_DIR/autojump
./install.py
