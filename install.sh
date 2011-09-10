#!/usr/bin/env bash


set -e


# Make backup(s) if nessesary then copy new config to $HOME
function copy_file {

    SOURCE="$CWD/$1"
    TARGET="${HOME}/${1/_/.}"

    if [ -e "${TARGET}" ]
    then
        BACKUP="$TARGET.bak"
        if [ -e "$BACKUP" ]
        then
            COUNT=0
            while [ -e "$BACKUP.$COUNT" ]; do let "COUNT += 1"; done
            BACKUP="$BACKUP.$COUNT"
        fi
        mv "$TARGET" "$BACKUP"
    fi

    cp -r "$SOURCE" "$TARGET"
}


CWD="$(dirname $0)"
DOWNLOAD_DIR="$CWD/download"
mkdir -p "$DOWNLOAD_DIR"


DOTFILES="
bashrc
gitconfig
profile
screenrc
shell-profile
"
for DOTFILE in $(echo "$DOTFILES")
do
    wget https://github.com/phunehehe/terminal-dotfiles/raw/master/_"$DOTFILE" \
         -O "$DOWNLOAD_DIR"/"$DOTFILE"
done


# Copy simple config files
for i in "$CWD"/_*
do
    copy_file $(basename $i)
done


# Setup modules
MODULES="
vim
"
for MODULE in $(echo "$MODULES")
do
    "$MODULE"/install.sh
done
