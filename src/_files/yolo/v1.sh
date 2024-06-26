#!/usr/bin/env bash
set -Eeuo pipefail

# curl-pipe-to-bash! if you don't want to install the rush CLI, but you DO want some of the packages
# in my rush-repo at <https://github.com/pcrockett/rush-repo>:
#
#     curl -SsfL http://philcrockett.com/yolo/v1.sh \
#         | bash -s -- <PACKAGE_NAMES...>
#
# this is basically the same thing as running `rush snatch ...`, but it supports multiple packages
# and doesn't require rush to be installed.
#
# especially handy for Dockerfiles.
#
# you don't need to use MY rush-repo. you can use another one by specifying the RUSH_REPO_OWNER env
# variable before running the script.

RUSH_REPO_OWNER=${RUSH_REPO_OWNER:-"pcrockett"}
ARGS=("${@}")

init() {
    TEMP_DIR="$(mktemp -d)"
    pushd "${TEMP_DIR}" &> /dev/null
    trap 'cleanup' EXIT SIGINT SIGTERM

    mkdir bin
    PATH="${TEMP_DIR}/bin:${PATH}"

    mkdir rush-repos
    export RUSH_ROOT="${PWD}/rush-repos"
    export RUSH_CONFIG="${PWD}/rush.ini"
}

cleanup() {
    popd &> /dev/null
    rm -rf "${TEMP_DIR}"
}

curl_download() {
    curl --proto '=https' --tlsv1.3 \
        --silent \
        --show-error \
        --fail \
        --location "${1}"
}

install_rush() {
    curl_download https://raw.githubusercontent.com/DannyBen/rush-cli/master/rush > bin/rush.tmp
    chmod +x bin/rush.tmp
    mv bin/rush.tmp bin/rush
}

get_packages() {
    for pkg in "${@}"; do
        rush get "${RUSH_REPO_OWNER}:${pkg}"
    done
}

main() {
    init
    install_rush
    rush clone --shallow "${RUSH_REPO_OWNER}"
    get_packages "${ARGS[@]}"
}

main
