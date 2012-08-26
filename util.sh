#!/bin/bash
set -e

stamp=terminal-dotfiles
now=$(date +'%Y-%m-%d_%H-%M-%S')
bin_dir="$(cd "$(dirname "$0")" && pwd)"

copy_files() {
    files="$1"
    for stuff in $files
    do
        destination="$HOME/${stuff/_/.}"
        [[ -h "$destination" ]] && rm "$destination"
        [[ -e "$destination" ]] && mv "$destination" "$destination.$stamp-$now"
        ln -sv "$bin_dir/$stuff" "$destination"
    done
}
