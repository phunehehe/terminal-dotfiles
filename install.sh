#!/bin/bash
set -e


bin_dir="$(cd "$(dirname "$0")" && pwd)"
. "$bin_dir/util.sh"

# Setup indie config files

dotfiles="
    _bashrc
    _dir_colors
    _gemrc
    _gitconfig
    _my.cnf
    _profile
    _psqlrc
    _screenrc
    _shrc
    _tmux.conf
    _zshrc
    _vim
    _vimrc
"

copy_files "$dotfiles"

mkdir -p ~/.fonts
ln -s powerline/font/PowerlineSymbols.otf ~/.fonts/
mkdir -p ~/.fonts.conf.d
ln -s powerline/font/10-powerline-symbols.conf ~/.fonts.conf.d
