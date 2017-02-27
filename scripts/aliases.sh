#!/usr/bin/env bash
#
# Shell Aliases

TFSHELL_APPS=$( cd "${BASH_SOURCE%/*}" && pwd )/apps

# autoload all aliases:
# for file in ./apps/{git,system}/aliases.sh; do
for file in $(find -H "$TFSHELL_APPS" -maxdepth 2 -name 'aliases.sh'); do
  # shellcheck source=/dev/null
  [ -r "$file" ] && [ -f "$file" ] && . "$file"
done
unset file
