#!/usr/bin/env bash
#
# AWS Functions

# shellcheck source=./../../support.sh
[[ -z "$TFSHELL_SUPPORT" ]] && . "$( cd "${BASH_SOURCE%/*}/../.." && pwd )/support.sh"

#######################################
# AWS ECR Docker Push, or exit
# Globals:
#   run_or_fail
# Arguments:
#   1 - DOCKER_IMAGE_NAME
#   2 - [optional] REGION || "us-east-1"
# Returns:
#   None
#######################################
aws_docker_push () {
  DOCKER_IMAGE_NAME="${1}"
  REGION="${2}" || "us-east-1"

  require_bin "docker"
  require_bin "aws"

  require_var "DOCKER_IMAGE_NAME"

  sh_info "Building Docker image: \`$DOCKER_IMAGE_NAME\`..."
  run_or_fail "sudo docker build -t $DOCKER_IMAGE_NAME ."

  sh_info "Getting login for AWS ECR (Docker repo hub)..."
  run_or_fail "sudo $(aws ecr get-login --region $REGION)"

  sh_info "Pushing Docker image \`$DOCKER_IMAGE_NAME\` to AWS ECR..."
  run_or_fail "sudo docker push ${DOCKER_IMAGE_NAME}"
}

#######################################
# AWS ECR URL
# Globals:
#   aws_docker_push
# Arguments:
#   1 - AWS_ACCOUNT_ID
#   2 - AWS_ECR_IMAGE_NAME
#   3 - [optional] AWS_ECR_IMAGE_TAG || "latest"
#   4 - [optional] AWS_REGION || "us-east-1"
# Returns:
#   AWS ECR URL
#######################################
aws_ecr_url () {
  AWS_ACCOUNT_ID="${1}"
  AWS_ECR_IMAGE_NAME="${2}"
  AWS_ECR_IMAGE_TAG="${3}" || "latest"
  AWS_REGION="${4}" || "us-east-1"

  require_var "AWS_ACCOUNT_ID"
  require_var "AWS_ECR_IMAGE_NAME"

  AWS_ECR_HOST="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

  echo "${AWS_ECR_HOST}/$AWS_ECR_IMAGE_NAME:${AWS_ECR_IMAGE_TAG}"
}

#######################################
# AWS S3 Upload, or exit
# Globals:
#   run_or_fail
# Arguments:
#   1 - LOCAL_FILE_NAME
#   2 - BUCKET name/domain
#   3 - [optional] REMOTE_FILE_NAME || LOCAL_FILE_NAME
#   4 - [optional] OPTS
# Returns:
#   None
#######################################
aws_s3_upload () {
  LOCAL_FILE_NAME="${1}"
  BUCKET="${2}"
  REMOTE_FILE_NAME="${3}" || "$LOCAL_FILE_NAME"
  OPTS="${4}" || ""

  require_bin "aws"

  require_var "LOCAL_FILE_NAME"
  require_var "BUCKET"

  cmd="aws s3 cp $LOCAL_FILE_NAME s3://$BUCKET/$REMOTE_FILE_NAME $OPTS"
  run_or_fail "$cmd"
}
