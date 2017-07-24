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
  DOCKER_IMAGE_NAME="${1}" || sh_fail "arg[1] - Docker image name is required"
  REGION="${2}" || "us-east-1"

  require_bin "docker"
  require_bin "aws"

  require_var "DOCKER_IMAGE_NAME"

  sh_info "Building Docker image: \`${DOCKER_IMAGE_NAME}\`..."
  run_or_fail sudo docker build -t ${DOCKER_IMAGE_NAME} .

  sh_info "Getting login for AWS ECR (Docker repo hub)..."
  run_or_fail sudo "$(aws ecr get-login --region ${REGION} | sed 's/-e none//')"

  sh_info "Pushing Docker image \`${DOCKER_IMAGE_NAME}\` to AWS ECR..."
  run_or_fail sudo docker push ${DOCKER_IMAGE_NAME}

  if [[ "$(docker images -q ${DOCKER_IMAGE_NAME} 2> /dev/null)" == "" ]]; then
    sh_fail "Failed while running docker push"
  fi

  sh_info "Removing Docker image; ${DOCKER_IMAGE_NAME}"
  docker rmi -f ${DOCKER_IMAGE_NAME} < /dev/null 2> /dev/null
}

#######################################
# AWS ECR URL
# Globals:
#   None
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

  AWS_ECR_URL=""

  if [ ! -z $AWS_ACCOUNT_ID ] && [ ! -z $AWS_ECR_IMAGE_NAME ]; then
    AWS_ECR_HOST="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"
    AWS_ECR_URL="$AWS_ECR_HOST/$AWS_ECR_IMAGE_NAME:$AWS_ECR_IMAGE_TAG"
  fi

  echo "${AWS_ECR_URL}"
}

#######################################
# AWS S3 Upload, or exit
# Globals:
#   aws
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

  require_func "run_or_fail"

  require_var "LOCAL_FILE_NAME"
  require_var "BUCKET"

  run_or_fail aws s3 cp ${LOCAL_FILE_NAME} s3://${BUCKET}/${REMOTE_FILE_NAME} ${OPTS}
}

#######################################
# AWS S3 Upload, with ZIP compression, or exit
# Globals:
#   aws_s3_upload
#   run_or_fail
#   zip
# Arguments:
#   1 - SRC_PATH
#   2 - LOCAL_FILE_NAME
#   3 - BUCKET name/domain
#   4 - [optional] REMOTE_FILE_NAME || LOCAL_FILE_NAME
#   5 - [optional] OPTS
# Returns:
#   None
#######################################
aws_s3_zip_upload () {
  SRC_PATH="${1}"
  LOCAL_FILE_NAME="${2}"
  BUCKET="${3}"
  REMOTE_FILE_NAME="${4}" || "$LOCAL_FILE_NAME"
  OPTS="${5}" || ""

  require_bin "zip"

  require_func "aws_s3_upload"
  require_func "run_or_fail"

  require_var "SRC_PATH"
  require_var "LOCAL_FILE_NAME"
  require_var "BUCKET"

  run_or_fail zip ${LOCAL_FILE_NAME} ${SRC_PATH}
  run_or_fail aws_s3_upload ${LOCAL_FILE_NAME} ${S3_BUCKET} ${REMOTE_FILE_NAME} ${OPTS}
}
