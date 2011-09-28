#!/usr/bin/env bash


set -e


# Make backup(s) if nessesary then copy new config to $HOME
function copy_file {

    source_file="$1"
    NAME="$(basename $source_file)"
    target="$HOME/${NAME/_/.}"

    if [ -e "$target" ]
    then
        BACKUP="$target.bak"
        if [ -e "$BACKUP" ]
        then
            COUNT=0
            while [ -e "$BACKUP.$COUNT" ]; do let "COUNT += 1"; done
            BACKUP="$BACKUP.$COUNT"
        fi
        mv "$target" "$BACKUP"
        echo "Backup file $BACKUP created."
    fi

    echo "Creating config file $target."
    cp -r "$source_file" "$target"
}


# Prepare the directories

cwd="$(dirname $0)"

VIM_DIR="$cwd/_vim"
COLORS_DIR="$VIM_DIR/colors"
AUTOLOAD_DIR="$VIM_DIR/autoload"
bundle_dir="$VIM_DIR/bundle"

mkdir -p "$VIM_DIR" "$COLORS_DIR" "$bundle_dir" "$AUTOLOAD_DIR"


# Download and install plugins

wget https://github.com/tpope/vim-pathogen/raw/master/autoload/pathogen.vim \
     -O "$AUTOLOAD_DIR"/pathogen.vim --quiet --no-check-certificate
wget https://github.com/vim-scripts/xoria256.vim/raw/master/colors/xoria256.vim \
     -O "$COLORS_DIR"/xoria256.vim --quiet --no-check-certificate

PLUGINS="
nerdtree;https://github.com/scrooloose/nerdtree/tarball/master
fuzzyfinder;https://bitbucket.org/ns9tks/vim-fuzzyfinder/get/tip.tar.gz
l9;https://bitbucket.org/ns9tks/vim-l9/get/tip.tar.gz
"
for plugin in $(echo "$PLUGINS")
do
    name=${plugin%;*}
    url=${plugin#*;}
    archive="$cwd/$name.tar.gz"
    wget "$url" -O "$archive" --quiet --no-check-certificate
    tar -xf "$archive" -C "$bundle_dir"
done


# And here comes the vimrc
wget https://github.com/phunehehe/terminal-dotfiles/raw/master/vim/_vimrc \
     -O "$cwd"/_vimrc --quiet --no-check-certificate


# The Great Move
for ITEM in "$cwd"/_*
do
    copy_file $ITEM
done
