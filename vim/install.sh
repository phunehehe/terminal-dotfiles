#!/bin/bash
set -e

bin_dir="$(cd "$(dirname "$0")" && pwd)"
. "$bin_dir/../util.sh"

dotfiles=(
    _vim
    _vimrc
)

copy_files "$dotfiles"
