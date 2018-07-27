#!/usr/bin/env bash

# shellcheck disable=SC1090,SC1091
[[ -z "$TFSHELL_SUPPORT" ]] && . "$( cd "${BASH_SOURCE%/*}/.." && pwd )"/scripts/support.sh

start=$(sh_start)

sh_msg "Testing \`sh_msg\` and \`sh_start\` ($start) functions"

# ------------------------------------------------------------------------------

sh_info "Testing \`lowercase\` function"

CAMEL_CASE="Word-Test"
LOWER_CASE="$(lowercase $CAMEL_CASE)"

if [ "word-test" == "$LOWER_CASE" ]; then
  sh_success "The \`lowercase\` function is working properly."
else
  sh_error "\`word-test\` did not equal \`$LOWER_CASE\`"
fi

# ------------------------------------------------------------------------------

sh_heading "Testing \`sh_heading\` function"
sh_text "Testing \`sh_text\` function"

sh_info "Testing \`sh_info\` function"
sh_note "Testing \`sh_note\` function"

response=
sh_user "Testing \`sh_user\` function. Type any response..."
read -e response
if [ ! -z "$response" ]; then
  sh_text "Your response: ${response}"
else
  sh_text "You did not respond."
fi

action=
sh_yesno "Testing \`sh_yesno\` function. Can you confirm?"
read -n 1 action
case "$action" in
  y )
    sh_text "Yes, confirmation, etc."
    ;;
  * )
    sh_text "No, negated, etc."
    ;;
esac

sh_alert "Testing \`sh_alert\` function"
sh_error "Testing \`sh_error\` function"
sh_success "Testing \`sh_success\` function"

# ------------------------------------------------------------------------------

sh_msg "Testing \`sh_end\` function..."

sh_end $start
