#!/usr/bin/env bash

# shellcheck disable=SC1090,SC1091
[[ -z "$TFSHELL_SUPPORT" ]] && . "$( cd "${BASH_SOURCE%/*}/.." && pwd )"/scripts/support.sh

sh_heading "Testing \`run_or_fail\` function"

sh_info "Testing positive result (\`npm --version\`)"

run_or_fail npm --version

sh_alert "Testing negative result (\`failing test\`)"

run_or_fail failing test
