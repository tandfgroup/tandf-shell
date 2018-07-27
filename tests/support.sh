#!/usr/bin/env bash

# shellcheck disable=SC1090,SC1091
[[ -z "$TFSHELL_SUPPORT" ]] && . "$( cd "${BASH_SOURCE%/*}/.." && pwd )"/scripts/support.sh

type "sh_success" &> /dev/null && sh_success "The \`sh_success\` function is available."
type "sh_start" &> /dev/null && sh_success "The \`sh_start\` function is available."
type "sh_end" &> /dev/null && sh_success "The \`sh_end\` function is available."
type "sh_msg" &> /dev/null && sh_success "The \`sh_msg\` function is available."
type "sh_text" &> /dev/null && sh_success "The \`sh_text\` function is available."
type "sh_code" &> /dev/null && sh_success "The \`sh_code\` function is available."
type "sh_note" &> /dev/null && sh_success "The \`sh_note\` function is available."
type "sh_info" &> /dev/null && sh_success "The \`sh_info\` function is available."
type "sh_alert" &> /dev/null && sh_success "The \`sh_alert\` function is available."
type "sh_error" &> /dev/null && sh_success "The \`sh_error\` function is available."
type "sh_fail" &> /dev/null && sh_success "The \`sh_fail\` function is available."
type "sh_user" &> /dev/null && sh_success "The \`sh_user\` function is available."

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

sh_code "Testing \`sh_code\` function"

sh_alert "Testing \`sh_alert\` function"
sh_error "Testing \`sh_error\` function"
sh_success "Testing \`sh_success\` function"

# ------------------------------------------------------------------------------

sh_msg "Testing \`sh_end\` function..."

sh_end $start

# sh_fail "Testing \`sh_fail\` function"

# ------------------------------------------------------------------------------

sh_msg "Testing \`file_find_key_replace\` function..."

TMP_DIR="$( cd "${BASH_SOURCE%/*}/.." && pwd )/tmp"
INPUT_FILE="${TMP_DIR}/input_file.txt"
OUTPUT_FILE="${TMP_DIR}/output_file.txt"

mkdir "$TMP_DIR"

cat > "$INPUT_FILE" <<- EOM
VAR={{VAR}}
EOM

sh_code "$(cat "$INPUT_FILE")"

VAR="VAR_VALUE"

declare -a VARS=(
  "VAR"
)

sh_code "$(cat "${VARS*}")"

(file_find_key_replace < /dev/null 2> /dev/null)
(file_find_key_replace "$INPUT_FILE" < /dev/null 2> /dev/null)
(file_find_key_replace "$INPUT_FILE" "VAR" "" "$OUTPUT_FILE" < /dev/null 2> /dev/null)

(file_find_keys_replace < /dev/null 2> /dev/null)
(file_find_keys_replace VARS[@] "$INPUT_FILE" "$OUTPUT_FILE" < /dev/null 2> /dev/null)

rm -rf "$TMP_DIR"

(require_func "mkdir" < /dev/null 2> /dev/null)
(require_func "xxyz" < /dev/null 2> /dev/null)
(require_bin "mkdir" < /dev/null 2> /dev/null)
(require_bin "xxyz" < /dev/null 2> /dev/null)
(require_bin "perl" < /dev/null 2> /dev/null)
(require_bin "semver" < /dev/null 2> /dev/null)
(require_var "VAR" < /dev/null 2> /dev/null)
(require_var "XXYZ" < /dev/null 2> /dev/null)

# shellcheck disable=SC2034
PREFIX_VAR="PREFIX_${VAR}"
(get_env_var "VAR" < /dev/null 2> /dev/null)
(get_env_var "VARZ" "DEFAULT_VAR" < /dev/null 2> /dev/null)
(get_env_var "VAR" "" "PREFIX_VAR" < /dev/null 2> /dev/null)
(get_env_var "XXYZ" < /dev/null 2> /dev/null)

(output_vars VARS[@] < /dev/null 2> /dev/null)
(output_vars_json VARS[@] < /dev/null 2> /dev/null)

(run_or_fail echo 'Success' < /dev/null 2> /dev/null)
(run_or_fail "echo 'Fail' && exit 2" < /dev/null 2> /dev/null)


(git_branch_name < /dev/null 2> /dev/null)
(BRANCH="$(git_branch_name)"; echo "BRANCH: $BRANCH") < /dev/null 2> /dev/null
(git_release_to_semver < /dev/null 2> /dev/null)
(SEMVER="$(git_release_to_semver)"; echo "SEMVER: $SEMVER") < /dev/null 2> /dev/null


(aws_s3_upload < /dev/null 2> /dev/null)
(aws_s3_upload "LOCAL_FILE_NAME" < /dev/null 2> /dev/null)
(aws_s3_upload "LOCAL_FILE_NAME" "AWS_S3_BUCKET" < /dev/null 2> /dev/null)
(aws_s3_upload "LOCAL_FILE_NAME" "AWS_S3_BUCKET" "REMOTE_FILE_NAME" < /dev/null 2> /dev/null)
(aws_s3_upload "LOCAL_FILE_NAME" "AWS_S3_BUCKET" "REMOTE_FILE_NAME" "OPTS" < /dev/null 2> /dev/null)

(aws_s3_zip_upload < /dev/null 2> /dev/null)
(aws_s3_zip_upload "SRC_PATH" < /dev/null 2> /dev/null)
(aws_s3_zip_upload "SRC_PATH" "LOCAL_FILE_NAME" < /dev/null 2> /dev/null)
(aws_s3_zip_upload "SRC_PATH" "LOCAL_FILE_NAME" "AWS_S3_BUCKET" < /dev/null 2> /dev/null)
(aws_s3_zip_upload "SRC_PATH" "LOCAL_FILE_NAME" "AWS_S3_BUCKET" "REMOTE_FILE_NAME" < /dev/null 2> /dev/null)
(aws_s3_zip_upload "SRC_PATH" "LOCAL_FILE_NAME" "AWS_S3_BUCKET" "REMOTE_FILE_NAME" "OPTS" < /dev/null 2> /dev/null)

(aws_ecr_url < /dev/null 2> /dev/null)
(aws_ecr_url "AWS_ACCOUNT_ID" < /dev/null 2> /dev/null)
(aws_ecr_url "AWS_ACCOUNT_ID" "AWS_ECR_IMAGE_NAME" < /dev/null 2> /dev/null)
(aws_ecr_url "AWS_ACCOUNT_ID" "AWS_ECR_IMAGE_NAME" "AWS_ECR_IMAGE_TAG" < /dev/null 2> /dev/null)
(aws_ecr_url "AWS_ACCOUNT_ID" "AWS_ECR_IMAGE_NAME" "AWS_ECR_IMAGE_TAG" "AWS_REGION" < /dev/null 2> /dev/null)

(aws_docker_login < /dev/null 2> /dev/null)
(aws_docker_login "us-east-1" < /dev/null 2> /dev/null)
(aws_docker_login "us-east-1" "yes" < /dev/null 2> /dev/null)

(aws_docker_push < /dev/null 2> /dev/null)
(aws_docker_push "AWS_ECR_IMAGE_URL" < /dev/null 2> /dev/null)
(aws_docker_push "AWS_ECR_IMAGE_URL" "us-east-1" < /dev/null 2> /dev/null)
(aws_docker_push "AWS_ECR_IMAGE_URL" "us-east-1" "yes" < /dev/null 2> /dev/null)

(aws_eb_create < /dev/null 2> /dev/null)
(aws_eb_create "APP_NAME" < /dev/null 2> /dev/null)
(aws_eb_create "APP_NAME" "latest" < /dev/null 2> /dev/null)
(aws_eb_create "APP_NAME" "latest" "AWS_S3_BUCKET" < /dev/null 2> /dev/null)
(aws_eb_create "APP_NAME" "latest" "AWS_S3_BUCKET" "AWS_S3_URI.zip" < /dev/null 2> /dev/null)

(aws_eb_update < /dev/null 2> /dev/null)
(aws_eb_update "APP_NAME" < /dev/null 2> /dev/null)
(aws_eb_update "APP_NAME" "latest" < /dev/null 2> /dev/null)
(aws_eb_update "APP_NAME" "latest" "APP_NAME_ENV" < /dev/null 2> /dev/null)

(aws_eb_health_check < /dev/null 2> /dev/null)
(aws_eb_health_check "APP_NAME_ENV" < /dev/null 2> /dev/null)
(aws_eb_health_check "APP_NAME_ENV" "1" < /dev/null 2> /dev/null)
(aws_eb_health_check "APP_NAME_ENV" "1" "1" < /dev/null 2> /dev/null)


exit 0
