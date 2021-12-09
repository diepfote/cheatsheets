#!/usr/bin/env bash

set -o pipefail  # propagate errors
set -u  # exit on undefined
set -e  # exit on non-zero return value
#set -f  # disable globbing/filename expansion
shopt -s failglob  # error on unexpaned globs


_help() {
cat <<EOF
USAGE: watch-namespace -n <NAMESPACE> -r <REGION>

OPTIONS:
  -n|--namespace NAMESPACE Namespace to watch
  --stop                   Stop watch
EOF
}

if [ $# -eq 0 ]; then
  _help
  exit
fi

# Parse arguments
USE_SUDO=''
while [ $# -gt 0 ]; do
key="$1"
  case "$key" in
    -r|--root)
    USE_SUDO=true
    shift
    ;;

    -d|--dir)
    DIR="$2"
    shift 2
    ;;

    -h|--help)
    _help
    exit 0
    ;;

    --)
    shift
    break
    ;;

    *)
    break
    ;;

  esac
done

