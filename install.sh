#!/usr/bin/env bash

set -uoe pipefail

INSTALL=true

parse_args() {
    while [[ $# -gt 0 ]]; do
        key="$1"

        case $key in
        -s | --skip-install)
            INSTALL=false
            shift # past argument
            ;;
        *)
            echo "Unrecognized argument $key"
            exit 1
            ;;
        esac
    done
}

parse_args "$@"

TARBALL_URL=$(curl -s https://api.github.com/repos/tekumara/setup-ubuntu/releases/latest | grep tarball | cut -d '"' -f 4)

if ! curl --progress-bar --fail -L "$TARBALL_URL" -o "/tmp/setup-ubuntu.tar.gz"; then
    echo "Download failed.  Check that the release/filename are correct."
    exit 1
fi

echo "Extracting install scripts to /tmp/"
tar -xvf /tmp/setup-ubuntu.tar.gz -C /tmp --strip-components=1

if [[ "$INSTALL" = false ]]; then
    echo "Skipping install"
else
    set -x

    export DEBIAN_FRONTEND=noninteractive
    sudo /tmp/install/system.sh
    sudo /tmp/install/docker.sh
    sudo /tmp/install/python.sh
    sudo /tmp/install/git.sh

    # brew cannot be installed as root, so don't use sudo
    sudo /tmp/install/brew.sh

fi
