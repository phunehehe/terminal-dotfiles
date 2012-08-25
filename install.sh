#!/bin/bash
set -e


bin_dir="$(cd "$(dirname "$0")" && pwd)"
"$bin_dir/util.sh"

# Setup indie config files

dotfiles=(
    _bashrc
    _gemrc
    _gitconfig
    _my.cnf
    _profile
    _psqlrc
    _screenrc
    _shrc
    _tmux.conf
    _zshrc
)

copy_files "$dotfiles"


# Setup modules

modules=(
    vim
)

for module in "${modules[@]}"
do
    "$bin_dir/$module/install.sh"
done
