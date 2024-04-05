#!/bin/bash

WORKDIR=/github/workspace

echo "Flatten submodules"

git -C "${WORKDIR}" config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
    while read -r KEY MODULE_PATH
    do
        DIR="$WORKDIR/$MODULE_PATH"

        if [ -d "$DIR" ]
        then
            if [ "$(ls -A $DIR)" ]; then
                echo "move $DIR to $WORKDIR"

                if [ -f "${DIR}/requirements.txt" ]
                then
                    echo "Remove ${DIR}/requirements.txt"
                    rm -rf "${DIR}/requirements.txt"
                fi

                cp -rf "${DIR}"/* "${WORKDIR}"
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
    if [ -f "${WORKDIR}/${name}" ]
    then
        rm -rf "${WORKDIR}/${name}"
    fi
done

for name in ${dirs[@]}; do
    if [ -d "${WORKDIR}/${name}" ]
    then
        rm -rf "${WORKDIR}/${name}"
    fi
done

# Clean dot filles
cd "$WORKDIR"
rm -rf .[!.]* ..?*
