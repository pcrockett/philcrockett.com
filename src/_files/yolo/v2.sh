#!/usr/bin/env bash
set -euo pipefail

# curl-pipe-to-bash! if you don't want to install the rush CLI, but you DO want some of
# the packages in my rush-repo at <https://github.com/pcrockett/rush-repo>:
#
#     curl -SsfL http://philcrockett.com/yolo/v2.sh \
#         | bash -s -- <PACKAGE_NAMES...>
#
# this is basically the same thing as running `rush snatch ...`, but it supports
# multiple packages and doesn't require rush to be installed.
#
# especially handy for Dockerfiles.
#
# you don't need to use MY rush-repo. you can use another one by specifying the
# RUSH_REPO_OWNER env variable before running the script.

RUSH_REPO_OWNER=${RUSH_REPO_OWNER:-"pcrockett"}
RUSH_VERSION=${RUSH_VERSION:-"v1.0.0"}
RUSH_CHECKSUM="${RUSH_CHECKSUM:-3b89b9854501f4f0391266d6d99f5307051560b26abd4edb98bd01572aea3d14}"
ARGS=("$@")

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

# shellcheck disable=SC2329  # cleanup is invoked indirectly via `trap`
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
  curl_download "https://github.com/DannyBen/rush/releases/download/${RUSH_VERSION}/rush" \
    > bin/rush.tmp
  checksum="$(sha256sum - <bin/rush.tmp)"
  if [ "${checksum}" != "${RUSH_CHECKSUM}  -" ]; then
    {
      echo "FATAL: Rush ${RUSH_VERSION} does not match the expected checksum."
      echo "You can specify a different checksum via the RUSH_CHECKSUM environment variable."
    } >&2
    exit 1
  fi
  mv bin/rush.tmp bin/rush
  chmod +x bin/rush
}

get_packages() {
  for pkg in "$@"; do
    rush get "${pkg}"
  done
}

main() {
  init
  install_rush
  rush clone --shallow "${RUSH_REPO_OWNER}"
  get_packages "${ARGS[@]}"
  exit $?
}

main
