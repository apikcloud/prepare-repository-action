#!/bin/bash

ADDONS_PATH=/github/workspace

echo "Flatten submodules"

git -C "${ADDONS_PATH}" config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
    while read -r KEY MODULE_PATH
    do
        DIR="$ADDONS_PATH/$MODULE_PATH"

        if [ -d "$DIR" ]
        then
            if [ "$(ls -A $DIR)" ]; then
                echo "move $DIR to $ADDONS_PATH"

                if [ -f "${DIR}/requirements.txt" ]
                then
                    echo "Remove ${DIR}/requirements.txt"
                    rm -rf "${DIR}/requirements.txt"
                fi

                cp -rf "${DIR}"/* "${ADDONS_PATH}"
            else
                echo "$DIR is Empty"
            fi
            rm -rf "$DIR"
        else
            echo "Directory $DIR not found."
        fi

    done

echo "Clean folders"

files=("README.md")
dirs=("setup")

for name in ${files[@]}; do
    if [ -f "${ADDONS_PATH}/${name}" ]
    then
        rm -rf "${ADDONS_PATH}/${name}"
    fi
done

for name in ${dirs[@]}; do
    if [ -d "${ADDONS_PATH}/${name}" ]
    then
        rm -rf "${ADDONS_PATH}/${name}"
    fi
done

# Clean dot filles
cd "$ADDONS_PATH"
rm -rf .[!.]* ..?*
