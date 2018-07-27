#!/usr/bin/env bats

. "${BATS_TEST_DIRNAME}/../scripts/functions/lowercase"

@test "lowercase exists" {
  run type lowercase
  [ "$status" -eq 0 ]
}

@test "lowercase with 'Hello World' argument" {
  run lowercase 'Hello World'
  [ "$output" == "hello world" ]
}
