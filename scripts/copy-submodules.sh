#!/bin/sh

REPO_PATH=/mnt/addons

# git config -f .gitmodules --get-regexp '^submodule\..*\.path$'
# git config -f .gitmodules --get-regexp '^submodule\..*\.path$' | awk '{print $NF}' | sed ':a;N;$!ba;s/\n/ /g'

export REPO_PATH=/mnt/addons && git config -f "${REPO_PATH}"/.gitmodules --get-regexp '^submodule\..*\.path$' | awk '{print $NF}' | sed ':a;N;$!ba;s/\n/ /g'


# if [ -d "$REPO_PATH/.git" ]
#     rm -rf "$REPO_PATH/.git"
# fi

# cd "$REPO_PATH"
# echo "$(pwd)"
# rm -rf .[!.]* ..?*

# rm .??



install_submodules() {
    git -C "${REPO_PATH}" config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
        while read -r KEY MODULE_PATH
        do
            # NAME="$(echo "${KEY}" | sed 's/^submodule\.\(.*\)\.path$/\1/')"

            # url_key="$(echo "${KEY}" | sed 's/\.path$/.url/')"
            # branch_key="$(echo "${KEY}" | sed 's/\.path$/.branch/')"

            # URL="$(git config -f .gitmodules --get "${url_key}")"
            # BRANCH="$(git config -f .gitmodules --get "${branch_key}" || echo "master")"

            DIR="$REPO_PATH/$MODULE_PATH"

            if [ -d "$DIR" ]
            then
                if [ "$(ls -A $DIR)" ]; then
                    echo "move $DIR to $REPO_PATH"
                    # echo "$(ls -al $DIR)"
                    cp -rf "${DIR}"/* "${REPO_PATH}"
                    rm -rf "$DIR"
                    # rm -rf .[!.]* ..?*

                else
                    echo "$DIR is Empty"
                    rm -rf "$DIR"
                fi
                # rm -rf "$DIR"
            else
                echo "Directory $DIR not found."
            fi

        done

}



install_submodules

if [ -d "${REPO_PATH}/setup" ]
then
    rm -rf "${REPO_PATH}/setup"
fi

cd "$REPO_PATH"
echo "$(pwd)"
rm -rf .[!.]* ..?*

rm "${REPO_PATH}/Dockerfile"

# declare -a ARRAY
# ARRAY=$(git config -f .gitmodules --get-regexp '^submodule\..*\.path$' | awk '{print $NF}' | sed ':a;N;$!ba;s/\n/ /g')
# echo ${ARRAY[0]}