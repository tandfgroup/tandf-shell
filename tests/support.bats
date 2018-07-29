#!/usr/bin/env bats

. "${BATS_TEST_DIRNAME}/../scripts/support.sh"

INPUT_FILE="${BATS_TMPDIR}/input_file.txt"
OUTPUT_FILE="${BATS_TMPDIR}/output_file.txt"

cat > "$INPUT_FILE" <<- EOM
VAR={{VAR}}
EOM

VAR="VAR_VALUE"

declare -a VARS=(
  "VAR"
)

PREFIX_VAR="PREFIX_${VAR}"

@test "'file_find_key_replace' should exist and work as expected" {
  run type file_find_key_replace
  [ "$status" -eq 0 ]
  run echo $(file_find_key_replace)
  [ "$output" = "$output" ]
  run echo $(file_find_key_replace "$INPUT_FILE")
  [ "$output" = "$output" ]
  run echo $(file_find_key_replace "$INPUT_FILE" "VAR")
  [ "$output" = "$output" ]
  run echo $(file_find_key_replace "$INPUT_FILE" "VAR" "")
  [ "$output" = "$output" ]
  run echo $(file_find_key_replace "$INPUT_FILE" "VAR" "" "$OUTPUT_FILE")
  [ "$output" = "$output" ]
}

@test "'file_find_keys_replace' should exist and work as expected" {
  run type file_find_keys_replace
  [ "$status" -eq 0 ]
  run echo $(file_find_keys_replace)
  [ "$output" = "$output" ]
  run echo $(file_find_keys_replace VARS[@])
  [ "$output" = "$output" ]
  run echo $(file_find_keys_replace VARS[@] "$INPUT_FILE")
  [ "$output" = "$output" ]
  run echo $(file_find_keys_replace VARS[@] "$INPUT_FILE" "$OUTPUT_FILE")
  [ "$output" = "$output" ]
}

@test "'require_func' should exist and work as expected" {
  run type require_func
  [ "$status" -eq 0 ]
  run echo $(require_func "mkdir")
  [ "$output" = "$output" ]
  run echo $(require_func "xxyz")
  [ "$output" = "$output" ]
}

@test "'require_bin' should exist and work as expected" {
  run type require_bin
  [ "$status" -eq 0 ]
  run echo $(require_bin "mkdir")
  [ "$output" = "$output" ]
  run echo $(require_bin "xxyz")
  [ "$output" = "$output" ]
  run echo $(require_bin "perl")
  [ "$output" = "$output" ]
  run echo $(require_bin "semver")
  [ "$output" = "$output" ]
}

@test "'require_var' should exist and work as expected" {
  run type require_var
  [ "$status" -eq 0 ]
  run echo $(require_var "VAR")
  [ "$output" = "$output" ]
  run echo $(require_var "XXYZ")
  [ "$output" = "$output" ]
}

@test "'get_env_var' should exist and work as expected" {
  run type get_env_var
  [ "$status" -eq 0 ]
  run echo $(get_env_var "VAR")
  [ "$output" = "$output" ]
  run echo $(get_env_var "VARZ" "DEFAULT_VAR")
  [ "$output" = "$output" ]
  run echo $(get_env_var "VAR" "" "PREFIX_VAR")
  [ "$output" = "$output" ]
  run echo $(get_env_var "XXYZ")
  [ "$output" = "$output" ]
}

@test "'output_vars' should exist and work as expected" {
  run type output_vars
  [ "$status" -eq 0 ]
  run echo $(output_vars VARS[@])
  [ "$output" = "$output" ]
}

@test "'output_vars_json' should exist and work as expected" {
  run type output_vars_json
  [ "$status" -eq 0 ]
  run echo $(output_vars_json VARS[@])
  [ "$output" = "$output" ]
}

@test "'run_or_fail' should exist and work as expected" {
  run type run_or_fail
  [ "$status" -eq 0 ]
  run echo $(run_or_fail echo 'Success')
  [ "$output" = "$output" ]
  run echo $(run_or_fail "echo 'Fail' && exit 2")
  [ "$output" = "$output" ]
}
