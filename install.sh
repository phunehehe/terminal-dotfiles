#!/usr/bin/env bash


set -e


# Make backup(s) if nessesary then copy new config to $HOME
function copy_file {

    SOURCE="$DOWNLOAD_DIR/$1"
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
_bashrc
_gitconfig
_profile
_screenrc
_shell-profile
"
for DOTFILE in $(echo "$DOTFILES")
do
    wget https://github.com/phunehehe/terminal-dotfiles/raw/master/"$DOTFILE" \
         -O "$DOWNLOAD_DIR"/"$DOTFILE"
done


# Copy simple config files
for i in "$DOWNLOAD_DIR"/_*
do
    copy_file $(basename $i)
done


# Setup modules
MODULES="
vim
"
for MODULE in $(echo "$MODULES")
do
    mkdir -p "$MODULE"
    INSTALL_SCRIPT="$MODULE/install.sh"
    chmod +x "$INSTALL_SCRIPT"
    ./"$INSTALL_SCRIPT"
done
