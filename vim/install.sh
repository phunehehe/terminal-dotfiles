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


# Prepare the directories

CWD="$(dirname $0)"
DOWNLOAD_DIR="$CWD/download"
VIM_DIR="$CWD/_vim"
COLORS_DIR="$VIM_DIR/colors"
AUTOLOAD_DIR="$VIM_DIR/autoload"
BUNDLE_DIR="$VIM_DIR/bundle"

mkdir -p "$VIM_DIR" "$DOWNLOAD_DIR" "$COLORS_DIR" "$BUNDLE_DIR" "$AUTOLOAD_DIR"


# Download and install plugins

wget https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim \
     -O "$AUTOLOAD_DIR"/pathogen.vim
wget https://raw.github.com/vim-scripts/xoria256.vim/master/colors/xoria256.vim \
     -O "$COLORS_DIR"/xoria256.vim

PLUGINS="
scrooloose/nerdtree
wincent/Command-T
"
for PLUGIN in $(echo "$PLUGINS")
do
    ARCHIVE="$DOWNLOAD_DIR/${PLUGIN/\//-}.tar.gz"
    wget "http://github.com/$PLUGIN/tarball/master" -O "$ARCHIVE"
    tar -xvf "$ARCHIVE" -C "$BUNDLE_DIR"
done


# And here comes the vimrc
wget https://github.com/phunehehe/terminal-dotfiles/raw/master/vim/_vimrc \
     -O _vimrc


# The Great Move
for ITEM in "$CWD"/_*
do
    copy_file $(basename $ITEM)
done


# CLean up
#rm -r "$DOWNLOAD_DIR" "$VIM_DIR"


# One last step for Command-T
cd ~/.vim/bundle/*Command-T*
rake make
