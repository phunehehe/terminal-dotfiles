#!/bin/bash

set -e


stamp=terminal-dotfiles
now=$(date +'%Y-%m-%d_%H-%M-%S')
bin_dir="$(cd "$(dirname "$0")" && pwd)"


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

for dotfile in "${dotfiles[@]}"
do
    destination="$HOME/${dotfile/_/.}"
    [[ -h "$destination" ]] && rm "$destination"
    [[ -e "$destination" ]] && mv "$destination" "$destination.$stamp-$now"
    ln -s "$bin_dir/$dotfile" "$destination"
done


# Setup modules

modules=(
vim
)

for module in "${modules[@]}"
do
    "$bin_dir/$module/install.sh"
done
