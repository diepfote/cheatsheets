#!/usr/bin/env bash

# all of these stem from https://www.shellcheck.net/wiki/
set -o pipefail  # propagate errors
set -u  # exit on undefined
set -e  # exit on non-zero return value
#set -f  # disable globbing/filename expansion
shopt -s failglob  # error on unexpaned globs
shopt -s inherit_errexit  # Bash disables set -e in command substitution by default; reverse this behavior


temp=./.local-build
temp_docs="$temp/docs"
rm -r "$temp" || true
mkdir "$temp"
mkdir "$temp_docs"
num_sec=500

find -name '*.txt' -exec sh -c 'mkdir -p '"$temp_docs"'/"$(dirname "$0")" && cp "$0" '"$temp_docs"'/"$0" ' {} \;
find -name '*.md' -exec sh -c 'mkdir -p '"$temp_docs"'/"$(dirname "$0")" && cp "$0" '"$temp_docs"'/"$0" ' {} \;
cp mkdocs.yml "$temp"
pushd "$temp"
mkdocs build
popd

echo
echo "[.] Site is available at: ${YELLOW}file://$(realpath "$temp/site/index.html")$NC"

