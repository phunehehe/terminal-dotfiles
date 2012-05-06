#!/usr/bin/env bash

set -e

export curl='curl --insecure --location --silent --show-error'


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
    mv "$SOURCE" "$TARGET"
}


CWD="$(dirname $0)"


DOTFILES=(
_bashrc
_gemrc
_gitconfig
_profile
_psqlrc
_screenrc
_shrc
_tmux.conf
_zshrc
)
for DOTFILE in "${DOTFILES[@]}"
do
    $curl > "$CWD/$DOTFILE" \
         https://github.com/phunehehe/terminal-dotfiles/raw/master/"$DOTFILE"
    copy_file "$DOTFILE"
done


# Setup modules
MODULES=(
vim
)
for MODULE in "${MODULES[@]}"
do
    mkdir -p "$MODULE"
    $curl https://github.com/phunehehe/terminal-dotfiles/raw/master/"$MODULES"/install.sh | bash -s
done
