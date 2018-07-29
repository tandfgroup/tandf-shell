#!/usr/bin/env bash
#
# Git Functions

# shellcheck disable=SC1090,SC1091
[[ -z "$TFSHELL_SUPPORT" ]] && . "$( cd "${BASH_SOURCE%/*}/../.." && pwd )/support.sh"

#######################################
# Get Git branch name
# i.e.; `feature/123-branch-name`
# Globals:
#   git
# Arguments:
#   None
# Returns:
#   Git branch name
#######################################
git_branch_name () {
  git symbolic-ref --quiet --short HEAD 2> /dev/null ||
  git rev-parse --short HEAD 2> /dev/null ||
  echo '(unknown)'
}

#######################################
# Get SEMVER from Git release branch
# i.e.; `release/1.2.3`
# Globals:
#   git
#   grep
#   sed
#   sort
#   tail
# Arguments:
#   None
# Returns:
#   SEMVER
#######################################
git_release_to_semver () {
  gitBranchName=$(git_branch_name);
  semver_from_release_branch "${gitBranchName}"
}

#######################################
# Get SEMVER from release branch
# i.e.; `release/1.2.3`
# Globals:
#   grep
#   sed
#   sort
#   tail
# Arguments:
#   1 - GIT_BRANCH_NAME
# Returns:
#   SEMVER
#######################################
semver_from_release_branch () {
  if [[ -z "${1:-}" ]]; then
    sh_error "arg[1] - {{GIT_BRANCH_NAME}} is required"
    exit 2
  fi
  # shellcheck disable=SC1117
  echo "${1}" |
    grep "^release\/[0-9]\+\.[0-9]\+\.[0-9]\+$" |
    sed 's/^release\///' |
    sort -t. -k 1,1n -k 2,2n -k 3,3n |
    tail -1
}
