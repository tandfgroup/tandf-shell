#!/usr/bin/env bash

# shellcheck disable=SC1090,SC1091
[[ -z "$TFSHELL_SUPPORT" ]] && . "$( cd "${BASH_SOURCE%/*}/.." && pwd )"/scripts/support.sh

sh_heading "Testing \`require_var\` function"

sh_info "Testing positive result (\`\$SHELL\`)"

require_var "SHELL"

sh_alert "Testing negative result (\`\$FAIL_REQUIRE_VAR_TEST\`)"

require_var "FAIL_REQUIRE_VAR_TEST"
