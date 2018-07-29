#!/usr/bin/env bats

. "${BATS_TEST_DIRNAME}/../scripts/support.sh"

@test "'git_branch_name' should exist and work as expected" {
  run type git_branch_name
  [ "$status" -eq 0 ]
  run echo $(git_branch_name)
  [ "$output" = "master" ]
}

@test "'git_release_to_semver' should exist and work as expected" {
  run type git_release_to_semver
  [ "$status" -eq 0 ]
  run echo $(git_release_to_semver)
  [ "$output" = "" ]
}

@test "'semver_from_release_branch' should exist and work as expected" {
  run type semver_from_release_branch
  [ "$status" -eq 0 ]
  run echo $(semver_from_release_branch)
  [ "$output" = "$output" ]
  run echo $(semver_from_release_branch "master")
  [ "$output" = "" ]
  run echo $(semver_from_release_branch "release/1.2.3")
  [ "$output" = "1.2.3" ]
}

@test "'git_branch_name' should return '(unknown)' if no branch found" {
  mv "${BATS_TEST_DIRNAME}/../.git" "${BATS_TEST_DIRNAME}/../_git"
  run echo $(git_branch_name)
  [ "$output" = "(unknown)" ]
  mv "${BATS_TEST_DIRNAME}/../_git" "${BATS_TEST_DIRNAME}/../.git"
}
