#!/usr/bin/env sh

# SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" 2> /dev/null && pwd -P)
echo "${SCRIPT_DIR}"
