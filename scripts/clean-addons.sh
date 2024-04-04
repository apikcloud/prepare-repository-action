#!/bin/bash

ADDONS_PATH=$1

files=("Dockerfile" "README.md")
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
