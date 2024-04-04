#!/bin/sh -l

ADDONS_PATH=/github/workspace

echo "flatten submodules"
flatten-submodules ${ADDONS_PATH}

echo "clean addons"
clean-addons ${ADDONS_PATH}
