#!/bin/sh -l

ADDONS_PATH=/github/workspace

echo "flatten submodules"
/scripts/flatten-submodules.sh ${ADDONS_PATH}

echo "clean addons"
/scripts/clean-addons.sh ${ADDONS_PATH}
