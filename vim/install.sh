#!/bin/bash

set -e


stamp=terminal-dotfiles
now=$(date +'%Y-%m-%d_%H-%M-%S')
bin_dir="$(cd "$(dirname "$0")" && pwd)"


# Setup indie config files

dotfiles=(
_vim
_vimrc
)

for dotfile in "${dotfiles[@]}"
do
    destination="$HOME/${dotfile/_/.}"
    [[ -h "$destination" ]] && rm "$destination"
    [[ -e "$destination" ]] && mv "$destination" "$destination.$stamp-$now"
    ln -s "$bin_dir/$dotfile" "$destination"
done
