#!/usr/bin/env bash


set -e


# Make backup(s) if nessesary then copy new config to $HOME
function copy_file {

    SOURCE="$1"
    NAME="$(basename $SOURCE)"
    TARGET="$HOME/${NAME/_/.}"

    if [ -e "$TARGET" ]
    then
        BACKUP="$TARGET.bak"
        if [ -e "$BACKUP" ]
        then
            COUNT=0
            while [ -e "$BACKUP.$COUNT" ]; do let "COUNT += 1"; done
            BACKUP="$BACKUP.$COUNT"
        fi
        mv "$TARGET" "$BACKUP"
        echo "Backup file $BACKUP created."
    fi

    echo "Creating config file $TARGET."
    cp -r "$SOURCE" "$TARGET"
}


CWD="$(dirname $0)"


DOTFILES="
_bashrc
_gemrc
_gitconfig
_profile
_psqlrc
_screenrc
_shrc
_tmux.conf
_zshrc
"
for DOTFILE in $(echo "$DOTFILES")
do
    wget https://github.com/phunehehe/terminal-dotfiles/raw/master/"$DOTFILE" \
         -O "$CWD"/"$DOTFILE" --quiet --no-check-certificate
    copy_file "$DOTFILE"
done


# Setup modules
MODULES="
vim
"
for MODULE in $(echo "$MODULES")
do
    mkdir -p "$MODULE"
    INSTALL_SCRIPT="$MODULE/install.sh"
    wget https://github.com/phunehehe/terminal-dotfiles/raw/master/"$MODULE"/install.sh \
         -O "$INSTALL_SCRIPT" --quiet --no-check-certificate
    chmod +x "$INSTALL_SCRIPT"
    ./"$INSTALL_SCRIPT"
done
