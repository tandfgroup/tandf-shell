#!/usr/bin/env bash
#
# Shell Support

# ------------------------------------------------------------------------------

# PATH VARIABLES

TFSHELL=$( cd "${BASH_SOURCE%/*}/.." && pwd )
export TFSHELL

TFSHELL_SCRIPTS=$TFSHELL/scripts
export TFSHELL_SCRIPTS

TFSHELL_SUPPORT=$TFSHELL_SCRIPTS/support.sh
export TFSHELL_SUPPORT

# ------------------------------------------------------------------------------

# LOAD DEPENDECIES

# shellcheck source=./response.sh
. $TFSHELL_SCRIPTS/response.sh

# shellcheck source=./functions.sh
. $TFSHELL_SCRIPTS/functions.sh

# ------------------------------------------------------------------------------

# OS SPEC VARIABLES

type "lowercase" &> /dev/null && [[ -z "$UTYPE" ]] && UTYPE=`lowercase ${OSTYPE}` && export UTYPE
type "lowercase" &> /dev/null && [[ -z "$UNAME" ]] && UNAME=`lowercase "\`uname\`"` && export UNAME
[[ -z "$UTYPE" ]] && UTYPE=`${OSTYPE}` && export UTYPE
[[ -z "$UNAME" ]] && UNAME=`uname` && export UNAME
[[ -z "$UREL" ]] && UREL=`uname -r` && export UREL
[[ -z "$UARCH" ]] && UARCH=`uname -p` && export UARCH
[[ -z "$UMACH" ]] && UMACH=`uname -m` && export UMACH

# ------------------------------------------------------------------------------

# SCRIPTING FUNCTIONS

#######################################
# File: Find "{{KEY}}" and Replace
# Globals:
#   None
# Arguments:
#   1 - File name or path
#   2 - Find string key
#   3 - Replace string value
#   4 - [optional] Output file name or path
# Returns:
#   None
#######################################
file_find_key_replace () {
  input_file="${1}" || sh_error "arg[1] - Input file name/path is required" && exit 2
  var_key="{{${2}}}" || sh_error "arg[2] - {{KEY}} is required" && exit 2
  var_value="${3}"
  output_file="${4}" || "$input_file"
  if type "sed" &> /dev/null && [ -z "$var_value" ]; then
    output=$(sed -e 's|'"$var_key"'|'"$var_value"'|g' $input_file)
    echo ${output} > $output_file
  fi
}
export file_find_replace

#######################################
# Require a function or exit
# Globals:
#   sh_fail
# Arguments:
#   1 - Function name
#   2 - [optional] Failure message
# Returns:
#   None
#######################################
require_func () {
  if type "$1" &> /dev/null; then
    : # silent pass if function exists
  else
    msg=$2 || "\`$1\` function was not found!"
    sh_fail "$msg"
  fi
}
export require_func

#######################################
# Require a binary (command) or exit
# Globals:
#   sh_fail
#   sh_success
# Arguments:
#   1 - Binary (command) name
#   2 - [optional] Failure message
# Returns:
#   None
#######################################
require_bin () {
  if type "$1" &> /dev/null; then
    sh_success "\`$1\` $($1 --version) installed: $(which $1)"
  else
    msg=$2 || "\`$1\` was not found!"
    sh_fail "$msg"
  fi
}
export require_bin

#######################################
# Require a variable or exit
# Globals:
#   sh_fail
#   sh_success
# Arguments:
#   1 - Variable name
#   2 - [optional] Failure message
# Returns:
#   None
#######################################
require_var () {
  var_name=${1}
  var_value=${!var_name}
  if [ -z "$var_value" ]; then
    msg=$2 || "\`\$$var_name\` was empty! ($var_value)"
    sh_fail "$msg"
  fi
  sh_success "\`\$$var_name\` = \"$var_value\""
}
export require_var

#######################################
# Run a command successfully, or exit
# Globals:
#   sh_fail
#   sh_success
# Arguments:
#   1 - Command(s) string
#   2 - [optional] Failure message
# Returns:
#   None
#######################################
run_or_fail () {
  sh_info "Running (\`$1\`), or failing..."
  $1
  if [ $? -ne 0 ]; then
    msg=$2 || "Failed while running (\`$1\`)"
    sh_fail "$msg"
  fi
}
export run_or_fail
