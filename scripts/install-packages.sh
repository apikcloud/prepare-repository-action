#!/bin/bash

ADDONS_PATH=$1
FILENAME="${ADDONS_PATH}/packages.txt"

if [ -f  ]
then
    apt-get install --no-install-recommends -y $(grep -vE "^\s*#" ${FILENAME}  | tr "\n" " ")

fi
