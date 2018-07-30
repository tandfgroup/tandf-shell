#!/usr/bin/env bats

. "${BATS_TEST_DIRNAME}/../scripts/support.sh"

@test "'sh_alert' should exist and work as expected" {
  run type sh_alert
  [ "$status" -eq 0 ]
  run echo $(sh_alert ">> test slug <<")
  [[ "$output" = *">> test slug <<"* ]]
}

@test "'sh_code' should exist and work as expected" {
  run type sh_code
  [ "$status" -eq 0 ]
  run echo $(sh_code ">> test slug <<")
  [[ "$output" = *">> test slug <<"* ]]
}

@test "'sh_end' should exist and work as expected" {
  run type sh_end
  [ "$status" -eq 0 ]
  run echo $(sh_end "$(sh_start)")
  [[ "$output" = *"runtime: 0:0"* ]]
}

@test "'sh_error' should exist and work as expected" {
  run type sh_error
  [ "$status" -eq 0 ]
  run echo $(sh_error ">> test slug <<")
  [[ "$output" = *">> test slug <<"* ]]
}

@test "'sh_fail' should exist and work as expected" {
  run type sh_fail
  [ "$status" -eq 0 ]
  run echo $(sh_fail ">> test slug <<")
  [[ "$output" = *">> test slug <<"* ]]
}

@test "'sh_heading' should exist and work as expected" {
  run type sh_heading
  [ "$status" -eq 0 ]
  run echo $(sh_heading ">> test slug <<")
  [[ "$output" = *">> test slug <<"* ]]
}

@test "'sh_info' should exist and work as expected" {
  run type sh_info
  [ "$status" -eq 0 ]
  run echo $(sh_info ">> test slug <<")
  [[ "$output" = *">> test slug <<"* ]]
}

@test "'sh_msg' should exist and work as expected" {
  run type sh_msg
  [ "$status" -eq 0 ]
  run echo $(sh_msg ">> test slug <<")
  [[ "$output" = *">> test slug <<"* ]]
}

@test "'sh_note' should exist and work as expected" {
  run type sh_note
  [ "$status" -eq 0 ]
  run echo $(sh_note ">> test slug <<")
  [[ "$output" = *">> test slug <<"* ]]
}

@test "'sh_start' should exist and work as expected" {
  run type sh_start
  [ "$status" -eq 0 ]
  run sh_start
  [ "$output" = "$(date +%s)" ]
}

@test "'sh_success' should exist and work as expected" {
  run type sh_success
  [ "$status" -eq 0 ]
  run echo $(sh_success ">> test slug <<")
  [[ "$output" = *">> test slug <<"* ]]
}

@test "'sh_text' should exist and work as expected" {
  run type sh_text
  [ "$status" -eq 0 ]
  run echo $(sh_text ">> test slug <<")
  [[ "$output" = *">> test slug <<"* ]]
}

@test "'sh_user' should exist and work as expected" {
  run type sh_user
  [ "$status" -eq 0 ]
  run echo $(sh_user ">> test slug <<")
  [[ "$output" = *">> test slug <<"* ]]
}

@test "'sh_yesno' should exist and work as expected" {
  run type sh_yesno
  [ "$status" -eq 0 ]
  run echo $(sh_yesno ">> test slug <<")
  [[ "$output" = *">> test slug <<"* ]]
}
