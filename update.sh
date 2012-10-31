#!/bin/bash
set -e
bin_dir="$(cd "$(dirname "$0")" && pwd)"
cd "$bin_dir"

git fetch
git merge origin/master --ff-only
git submodule update --init --recursive

./install.sh
