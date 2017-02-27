#!/usr/bin/env bash

# shellcheck source=./../scripts/support.sh
[[ -z "$TFSHELL_SUPPORT" ]] && . "$( cd "${BASH_SOURCE%/*}/.." && pwd )"/scripts/support.sh

sh_heading "Testing \`require_bin\` function"

sh_info "Testing positive result (\`sh\`)"

require_bin "sh"

sh_alert "Testing negative result (\`abcxyz\`)"

require_bin "abcxyz"
