#!/usr/bin/env bash

# shellcheck source=./../scripts/support.sh
[[ -z "$TFSHELL_SUPPORT" ]] && . "$( cd "${BASH_SOURCE%/*}/.." && pwd )"/scripts/support.sh

sh_heading "Testing \`run_or_fail\` function"

sh_info "Testing positive result (\`npm --version\`)"

run_or_fail "npm --version"

sh_alert "Testing negative result (\`failing test\`)"

cmd="failing test"
run_or_fail "$cmd" "the test failed, with a custom message in the 2nd argument!"
