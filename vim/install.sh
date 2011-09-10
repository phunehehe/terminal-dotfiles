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


# Prepare the directories

CWD="$(dirname $0)"

VIM_DIR="$CWD/_vim"
COLORS_DIR="$VIM_DIR/colors"
AUTOLOAD_DIR="$VIM_DIR/autoload"
BUNDLE_DIR="$VIM_DIR/bundle"

mkdir -p "$VIM_DIR" "$COLORS_DIR" "$BUNDLE_DIR" "$AUTOLOAD_DIR"


# Download and install plugins

wget https://github.com/tpope/vim-pathogen/raw/master/autoload/pathogen.vim \
     -O "$AUTOLOAD_DIR"/pathogen.vim --quiet
wget https://github.com/vim-scripts/xoria256.vim/raw/master/colors/xoria256.vim \
     -O "$COLORS_DIR"/xoria256.vim --quiet

PLUGINS="
scrooloose/nerdtree
wincent/Command-T
"
for PLUGIN in $(echo "$PLUGINS")
do
    ARCHIVE="$CWD/${PLUGIN/\//-}.tar.gz"
    wget "http://github.com/$PLUGIN/tarball/master" -O "$ARCHIVE" --quiet
    tar -xf "$ARCHIVE" -C "$BUNDLE_DIR"
done


# And here comes the vimrc
wget https://github.com/phunehehe/terminal-dotfiles/raw/master/vim/_vimrc \
     -O "$CWD"/_vimrc --quiet


# The Great Move
for ITEM in "$CWD"/_*
do
    copy_file $ITEM
done


# One last step for Command-T
cd ~/.vim/bundle/*Command-T*
rake make --quiet
