#!/bin/bash
# Inspired by https://gohugo.io/hosting-and-deployment/hosting-on-github/

set -Eeuo pipefail

SCRIPT_DIR="$(dirname "$(readlink -f "${0}")")"
SITE_DIR_NAME="_site"
SITE_DIR="${SCRIPT_DIR}/${SITE_DIR_NAME}"
pushd "${SCRIPT_DIR}" > /dev/null

if [ "$(git status --short)" ]; then
    echo "The working directory is dirty. Commit or stash any pending changes."
    exit 1;
fi

# We don't know if we're in a freshly-cloned repo, or if the repo has been
# properly set up to publish. So let's just reset the state of this repo
# as if it had never been set up for publishing, and then set it up ourselves.
echo "Deleting old publication"
rm --recursive --force "${SITE_DIR}"
mkdir "${SITE_DIR}"
git worktree prune
rm --recursive --force ".git/worktrees/${SITE_DIR}/"

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages "${SITE_DIR_NAME}" origin/gh-pages

echo "Removing existing files"
rm --recursive --force "${SITE_DIR:?}/*"

echo "Generating site"
npm run build

echo "Updating gh-pages branch"
cd "${SITE_DIR}" && git add --all && git commit -m "Publish to GitHub pages"

echo "Use \"git push --all\" to finish publishing."

popd > /dev/null
