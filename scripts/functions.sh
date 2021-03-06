#!/usr/bin/env bash
#
# Shell Functions

TFSHELL_FUNCTIONS=$( cd "${BASH_SOURCE%/*}/functions" && pwd )
export TFSHELL_FUNCTIONS

# autoload every function:
# for file in ./functions/{extract,lowercase}; do
# shellcheck disable=SC2044
for file in $(find -H "$TFSHELL_FUNCTIONS" -maxdepth 2 -name '[A-Za-z0-9\-\_]*'); do
  # shellcheck disable=SC1090,SC1091,SC2163
  [ -r "$file" ] && [ -f "$file" ] && . "$file" && export "$(basename "$file")"
done
unset file

# ------------------------------------------------------------------------------

# autoload all app-related functions:
TFSHELL_APPS=$( cd "${BASH_SOURCE%/*}/apps" && pwd )
# for file in ./apps/**/functions.sh; do
# shellcheck disable=SC2044
for file in $(find -H "$TFSHELL_APPS" -maxdepth 2 -name 'functions.sh'); do
  # shellcheck disable=SC1090,SC1091
  [ -r "$file" ] && [ -f "$file" ] && . "$file"
done
unset file

# ------------------------------------------------------------------------------

# autoload all service-related functions:
TFSHELL_SERVICES=$( cd "${BASH_SOURCE%/*}/services" && pwd )
# for file in ./services/**/functions.sh; do
# shellcheck disable=SC2044
for file in $(find -H "$TFSHELL_SERVICES" -maxdepth 2 -name 'functions.sh'); do
  # shellcheck disable=SC1090,SC1091
  [ -r "$file" ] && [ -f "$file" ] && . "$file"
done
unset file
