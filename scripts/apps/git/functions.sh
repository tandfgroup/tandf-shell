#!/usr/bin/env bash
#
# Git Functions

# shellcheck source=./../../support.sh
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
  gitBranchName=$(
    git symbolic-ref --quiet --short HEAD 2> /dev/null ||
    git rev-parse --short HEAD 2> /dev/null ||
    echo '(unknown)'
  );
  echo $gitBranchName
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
  gitBranchName=$(
    git symbolic-ref --quiet --short HEAD 2> /dev/null ||
    git rev-parse --short HEAD 2> /dev/null ||
    echo '(unknown)'
  );
  semver=$(
    echo ${gitBranchName} |
    grep "^release\/[0-9]\+\.[0-9]\+\.[0-9]\+$" |
    sed 's/^release\///' |
    sort -t. -k 1,1n -k 2,2n -k 3,3n |
    tail -1
  );
  echo $semver
}
