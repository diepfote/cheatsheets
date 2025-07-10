#!/usr/bin/env bash

# all of these stem from https://www.shellcheck.net/wiki/
set -o pipefail  # propagate errors
set -u  # exit on undefined
set -e  # exit on non-zero return value
#set -f  # disable globbing/filename expansion
shopt -s failglob  # error on unexpaned globs
shopt -s inherit_errexit  # Bash disables set -e in command substitution by default; reverse this behavior


temp="$(mktemp -d)"
temp_docs="$temp"/docs
num_sec=500
cleanup () { rm -r "$temp"; }
trap cleanup EXIT

mkdir "$temp_docs"
find -name '*.txt' -exec sh -c 'mkdir -p '"$temp_docs"'/"$(dirname "$0")" && cp "$0" '"$temp_docs"'/"$0" ' {} \;
find -name '*.md' -exec sh -c 'mkdir -p '"$temp_docs"'/"$(dirname "$0")" && cp "$0" '"$temp_docs"'/"$0" ' {} \;
cp mkdocs.yml "$temp"
cd "$temp"
mkdocs build

echo
echo "[.] Site is available at: $temp/site/index.html"
echo "[.] Clearing in $RED$num_sec$NC seconds."
sleep "$num_sec"

