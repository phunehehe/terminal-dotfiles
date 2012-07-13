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
    mv "$source_file" "$target"
}


# Prepare the directories

cwd="$(dirname $0)"

vim_dir="$cwd/_vim"
colors_dir="$vim_dir/colors"
autoload_dir="$vim_dir/autoload"
bundle_dir="$vim_dir/bundle"

mkdir -p "$vim_dir" "$colors_dir" "$bundle_dir" "$autoload_dir"


# Download and install plugins

$curl > "$autoload_dir"/pathogen.vim \
     https://github.com/tpope/vim-pathogen/raw/master/autoload/pathogen.vim
$curl > "$colors_dir"/xoria256.vim \
     https://github.com/vim-scripts/xoria256.vim/raw/master/colors/xoria256.vim

plugins=(
https://github.com/scrooloose/nerdtree/tarball/master
https://github.com/kien/ctrlp.vim/tarball/master
https://github.com/Lokaltog/vim-easymotion/tarball/master
https://github.com/pangloss/vim-javascript/tarball/master
https://github.com/kchmck/vim-coffee-script/tarball/master
https://github.com/tpope/vim-fugitive/tarball/master
https://github.com/tpope/vim-eunuch/tarball/master
https://github.com/tpope/vim-surround/tarball/master
)
for url in "${plugins[@]}"
do
    archive="$cwd/master.tar.gz"
    $curl "$url" | tar -xz -C "$bundle_dir"
done


# And here comes the vimrc
$curl > "$cwd"/_vimrc \
     https://github.com/phunehehe/terminal-dotfiles/raw/master/vim/_vimrc \


# The Great Move
for item in "$cwd"/_*
do
    copy_file $item
done
