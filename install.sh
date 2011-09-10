#!/usr/bin/env bash

# Make backup(s) if nessesary then copy new config to $HOME
function copy_file {

    SOURCE="${PWD}/$1"
    TARGET="${HOME}/${1/_/.}"

    if [ -e "${TARGET}" ]
    then
        BACKUP="$TARGET.bak"
        if [ -e "$BACKUP" ]
        then
            COUNT=0
            while [ -e "$BACKUP.$COUNT" ]; do let "COUNT += 1"; done
            BACKUP="$BACKUP.$COUNT"
        fi
        mv "$TARGET" "$BACKUP"
    fi

    cp -r "$SOURCE" "$TARGET"
}


# Copy simple config files
for i in _*
do
    copy_file $i
done

# Setup modules
MODULES="
vim
"
for MODULE in $(echo "$MODULES")
do
    "$MODULE"/install.sh
done
