#!/usr/bin/env bash

set -e

# Make backup(s) if nessesary then copy new config to $HOME
function copy_file {

    source_file="$1"
    name="$(basename $source_file)"
    target="$HOME/${name/_/.}"

    if [ -e "$target" ]
    then
        backup="$target.bak"
        if [ -e "$backup" ]
        then
            count=0
            while [ -e "$backup.$count" ]; do let "count += 1"; done
            backup="$backup.$count"
        fi
        mv "$target" "$backup"
        echo "Backup file $backup created."
    fi

    echo "Creating config file $target."
    cp -r "$source_file" "$target"
}


# Prepare the directories

cwd="$(dirname $0)"

vim_dir="$cwd/_vim"
colors_dir="$vim_dir/colors"
autoload_dir="$vim_dir/autoload"
bundle_dir="$vim_dir/bundle"

mkdir -p "$vim_dir" "$colors_dir" "$bundle_dir" "$autoload_dir"


# Download and install plugins

wget https://github.com/tpope/vim-pathogen/raw/master/autoload/pathogen.vim \
     -O "$autoload_dir"/pathogen.vim --quiet --no-check-certificate
wget https://github.com/vim-scripts/xoria256.vim/raw/master/colors/xoria256.vim \
     -O "$colors_dir"/xoria256.vim --quiet --no-check-certificate

plugins="
nerdtree;https://github.com/scrooloose/nerdtree/tarball/master
ctrlp.vim;https://github.com/kien/ctrlp.vim/tarball/master
easymotion;https://github.com/Lokaltog/vim-easymotion/tarball/master
"
for plugin in $(echo "$plugins")
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
for item in "$cwd"/_*
do
    copy_file $item
done
