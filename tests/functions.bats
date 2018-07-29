#!/usr/bin/env bats

. "${BATS_TEST_DIRNAME}/../scripts/support.sh"

@test "'dataurl' should exist and work as expected" {
  run type dataurl
  [ "$status" -eq 0 ]
  run echo $(dataurl)
  [ "$output" = "ERROR: No file specified." ]
  run echo $(dataurl "package.json")
  [[ "$output" = "data:text/plain;charset=utf-8;base64,"* ]]
}

@test "'docker_clean' should exist and work as expected" {
  run type docker_clean
  [ "$status" -eq 0 ]
}

@test "'docker_kill_all' should exist and work as expected" {
  run type docker_kill_all
  [ "$status" -eq 0 ]
}

@test "'docker_rm_all' should exist and work as expected" {
  run type docker_rm_all
  [ "$status" -eq 0 ]
}

@test "'docker_rmi_all' should exist and work as expected" {
  run type docker_rmi_all
  [ "$status" -eq 0 ]
}

@test "'dotenv' should exist and work as expected" {
  run type dotenv
  [ "$status" -eq 0 ]
  run echo $(dotenv "${BATS_TEST_DIRNAME}/../.env" && cat "${BATS_TEST_DIRNAME}/../.env")
  [[ "$output" = *"APP_NAME=\"tandf-shell\""* ]]
}

@test "'fs' should exist and work as expected" {
  run type fs
  [ "$status" -eq 0 ]
  run echo $(fs)
  [[ "$output" = *"package.json"* ]]
  run echo $(fs "./")
  [[ "$output" = *"./"* ]]
}

@test "'gethost' should exist and work as expected" {
  run type gethost
  [ "$status" -eq 0 ]
  run echo $(gethost)
  [ "$output" = "ERROR: No domain specified." ]
  run echo $(gethost "www.google.com")
  [ "$output" = "ERROR: No DNS specified." ]
  run echo $(gethost "iluwsefgh.uhr" "192.168.1.1")
  [ "$output" = "ERROR: iluwsefgh.uhr not found on 192.168.1.1" ]
  run echo $(gethost "www.google.com" "8.8.8.8")
  [[ "$output" = *"www.google.com"* ]]
  # run echo $(gethost "localhost" "192.168.1.1")
  # [[ "$output" = *"127.0.0.1 localhost"* ]]
}

@test "'git_release_to_semver' should exist and work as expected" {
  run type git_release_to_semver
  [ "$status" -eq 0 ]
  run echo $(git_release_to_semver)
  [ "$output" = "" ]
}

@test "'lowercase' should exist and work as expected" {
  run type lowercase
  [ "$status" -eq 0 ]
  run echo $(lowercase "Hello World")
  [ "$output" = "hello world" ]
}

@test "'targz' should exist and work as expected" {
  run type targz
  [ "$status" -eq 0 ]
  run echo $(targz "tests")
  [[ "$output" = *"tests.tar.gz"* ]]
}

@test "'tre' should exist and work as expected" {
  run type tre
  [ "$status" -eq 0 ]
  run echo $(tre)
  [[ "$output" = *"package.json"* ]]
}

@test "'uppercase' should exist and work as expected" {
  run type uppercase
  [ "$status" -eq 0 ]
  run echo $(uppercase "Hello World")
  [ "$output" = "HELLO WORLD" ]
}

