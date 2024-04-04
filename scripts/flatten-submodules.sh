#!/bin/sh

ADDONS_PATH=$1

git -C "${ADDONS_PATH}" config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
    while read -r KEY MODULE_PATH
    do
        DIR="$ADDONS_PATH/$MODULE_PATH"

        if [ -d "$DIR" ]
        then
            if [ "$(ls -A $DIR)" ]; then
                echo "move $DIR to $ADDONS_PATH"
                cp -rf "${DIR}"/* "${ADDONS_PATH}"
            else
                echo "$DIR is Empty"
            fi
            rm -rf "$DIR"
        else
            echo "Directory $DIR not found."
        fi

    done
