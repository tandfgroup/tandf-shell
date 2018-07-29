#!/usr/bin/env bash
#
# AWS Functions

# shellcheck disable=SC1091,SC1090
[[ -z "${TFSHELL_SUPPORT:-}" ]] && . "$( cd "${BASH_SOURCE%/*}/../.." && pwd )/support.sh"

#######################################
# AWS ECR Docker Login, or exit
# Globals:
#   run_or_fail
# Arguments:
#   1 - [optional] AWS_REGION || "us-east-1"
#   2 - [optional] USE_SUDO || disabled
# Returns:
#   None
#######################################
aws_docker_login () {
  AWS_REGION="${1:-}"
  [[ -z "${AWS_REGION}" ]] && AWS_REGION="us-east-1"
  USE_SUDO="${2:-}"

  sh_info "Getting login for AWS ECR (Docker repo hub)..."
  require_bin "aws"
  # TODO: The horrible sed hack removes the "-e" parameter from the docker login command.
  # Later versions of the AWS CLI (>=1.11.91) support --no-include-email on the get-login command.
  DOCKER_LOGIN=$(aws ecr get-login --region ${AWS_REGION} | sed 's/-e none //')
  if [[ ! -z "${USE_SUDO}" ]]; then
    require_bin "docker" && run_or_fail sudo "$DOCKER_LOGIN"
  else
    require_bin "docker" && run_or_fail "$DOCKER_LOGIN"
  fi
}

#######################################
# AWS ECR Docker Push, or exit
# Globals:
#   run_or_fail
# Arguments:
#   1 - AWS_ECR_IMAGE_URL
#   2 - [optional] AWS_REGION || "us-east-1"
#   3 - [optional] USE_SUDO || disabled
# Returns:
#   None
#######################################
aws_docker_push () {
  if [[ -z "${1:-}" ]]; then
    sh_error "arg[1] - {{AWS_ECR_IMAGE_URL}} is required"
    exit 2
  fi
  AWS_ECR_IMAGE_URL="${1}" && require_var "AWS_ECR_IMAGE_URL"
  AWS_REGION="${2:-}"
  [[ -z "${AWS_REGION}" ]] && AWS_REGION="us-east-1"
  USE_SUDO="${3:-}"

  sh_info "Pushing Docker image \`${AWS_ECR_IMAGE_URL}\` to AWS ECR..."
  
  aws_docker_login "$AWS_REGION" "$USE_SUDO"

  if [[ ! -z "${USE_SUDO}" ]]; then
    require_bin "docker" && run_or_fail sudo docker push "${AWS_ECR_IMAGE_URL}"
  else
    require_bin "docker" && run_or_fail docker push "${AWS_ECR_IMAGE_URL}"
  fi

  if [[ "$(docker images -q "${AWS_ECR_IMAGE_URL}" 2> /dev/null)" = "" ]]; then
    sh_fail "Failed while running docker push"
  fi
  sh_info "Removing Docker image; ${AWS_ECR_IMAGE_URL}"
  require_bin "docker" && docker rmi -f "$AWS_ECR_IMAGE_URL" < /dev/null 2> /dev/null
}

#######################################
# AWS ElasticBeanstalk Create-Application-Version
# Globals:
#   aws
# Arguments:
#   1 - APP_NAME
#   2 - APP_TAG
#   3 - AWS_S3_BUCKET
#   4 - AWS_S3_URI
# Returns:
#   None
#######################################
aws_eb_create () {
  if [[ -z "${1:-}" ]]; then
    sh_error "arg[1] - {{APP_NAME}} is required"
    exit 2
  elif [[ -z "${2:-}" ]]; then
    sh_error "arg[2] - {{APP_TAG}} is required"
    exit 2
  elif [[ -z "${3:-}" ]]; then
    sh_error "arg[3] - {{AWS_S3_BUCKET}} is required"
    exit 2
  elif [[ -z "${4:-}" ]]; then
    sh_error "arg[4] - {{AWS_S3_URI}} is required"
    exit 2
  fi
  APP_NAME="${1}"
  APP_TAG="${2}"
  AWS_S3_BUCKET="${3}"
  AWS_S3_URI="${4}"

  require_func "run_or_fail"

  sh_info "Creating AWS Elastic Beanstalk Application (create new app version)"
  require_bin "aws" && run_or_fail aws elasticbeanstalk create-application-version \
    --application-name "$APP_NAME" \
    --version-label "$APP_TAG" \
    --description "${APP_NAME}:${APP_TAG}" \
    --source-bundle "S3Bucket=${AWS_S3_BUCKET},S3Key=${AWS_S3_URI}"
}

#######################################
# AWS ElasticBeanstalk Update-Environment
# Globals:
#   aws
# Arguments:
#   1 - APP_NAME
#   2 - APP_TAG
#   3 - APP_NAME_ENV
# Returns:
#   None
#######################################
aws_eb_update () {
  if [[ -z "${1:-}" ]]; then
    sh_error "arg[1] - {{APP_NAME}} is required"
    exit 2
  elif [[ -z "${2:-}" ]]; then
    sh_error "arg[2] - {{APP_TAG}} is required"
    exit 2
  elif [[ -z "${3:-}" ]]; then
    sh_error "arg[3] - {{APP_NAME_ENV}} is required"
    exit 2
  fi
  APP_NAME="${1}"
  APP_TAG="${2}"
  APP_NAME_ENV="${3}"

  require_func "run_or_fail"

  sh_info "Updating AWS Elastic Beanstalk Environment (deploy new app version)"
  require_bin "aws" && run_or_fail aws elasticbeanstalk update-environment \
    --application-name "$APP_NAME" \
    --version-label "$APP_TAG" \
    --environment-name "$APP_NAME_ENV"

  # Wait for AWS Beantsalk to deploy the version successfully.
  DEPLOY_RETRY_NUMBER=10
  DEPLOY_RETRY_INTERVAL=60
  DEPLOY_RETRY_COUNT=1
  DEPLOY_HEALTH="Red"
  DEPLOY_HEALTH_READY="Green"

  while [[ $DEPLOY_RETRY_COUNT -le $DEPLOY_RETRY_NUMBER ]]; do
    sh_info "Checking for 'Green' deployment-health-status (${DEPLOY_RETRY_COUNT}...)"
    DEPLOY_RETRY_COUNT=$(( $DEPLOY_RETRY_COUNT + 1 ))
    DEPLOY_HEALTH=$(aws elasticbeanstalk describe-environments --environment-names $APP_NAME_ENV | jq -c -r ".Environments[0].Health")
    sh_info "Current elasticbeanstalk health status - ${DEPLOY_HEALTH}"

    [[ "${DEPLOY_HEALTH}" = "${DEPLOY_HEALTH_READY}" ]] && break

    sh_info "Waiting For The Deployment To Finish"
    sleep $DEPLOY_RETRY_INTERVAL
    sh_info "${DEPLOY_RETRY_COUNT}"
  done

  if [[ "${DEPLOY_HEALTH}" = "${DEPLOY_HEALTH_READY}" ]]; then
    sh_success "The deployment was successful!"
  else
    sh_alert "Exceeded retry-limit (${DEPLOY_RETRY_NUMBER})."
    sh_alert "Deployment Health Status: ${DEPLOY_HEALTH}"
    [[ "${DEPLOY_HEALTH}" = "Red" ]] && sh_fail "The deployment was not successful!"
    sh_alert "The deployment may not have been successful."
  fi
}

#######################################
# AWS ElasticBeanstalk Describe-Environment Health
# Globals:
#   aws
#   jq
# Arguments:
#   1 - APP_ENVIRONMENT_NAME
#   2 - [optional] DEPLOY_RETRY_NUMBER || 10
#   3 - [optional] DEPLOY_RETRY_INTERVAL || 60 # seconds
# Returns:
#   None
#######################################
aws_eb_health_check () {
  if [[ -z "${1:-}" ]]; then
    sh_error "arg[1] - {{APP_ENVIRONMENT_NAME}} is required"
    exit 2
  fi
  APP_ENVIRONMENT_NAME="${1}"
  DEPLOY_RETRY_NUMBER="${2:-}"
  [[ -z "${DEPLOY_RETRY_NUMBER}" ]] && DEPLOY_RETRY_NUMBER=10
  DEPLOY_RETRY_INTERVAL="${3:-}"
  [[ -z "${DEPLOY_RETRY_INTERVAL}" ]] && DEPLOY_RETRY_INTERVAL=60

  DEPLOY_HEALTH="Red"
  DEPLOY_HEALTH_READY="Green"
  DEPLOY_RETRY_COUNT=1

  require_bin "aws"

  # Wait for AWS Beantsalk to deploy the version successfully.
  while [[ $DEPLOY_RETRY_COUNT -le $DEPLOY_RETRY_NUMBER ]]; do
    sh_info "Checking for 'Green' deployment-health-status (${DEPLOY_RETRY_COUNT}...)"
    DEPLOY_RETRY_COUNT=$(( DEPLOY_RETRY_COUNT + 1 ))
    DEPLOY_HEALTH=$(aws elasticbeanstalk describe-environments --environment-names "$APP_ENVIRONMENT_NAME" | jq -c -r ".Environments[0].Health")
    sh_info "Current elasticbeanstalk health status - ${DEPLOY_HEALTH}"

    [[ "${DEPLOY_HEALTH}" = "${DEPLOY_HEALTH_READY}" ]] && break

    sh_info "Waiting For The Deployment To Finish"
    sleep $DEPLOY_RETRY_INTERVAL
    sh_info "${DEPLOY_RETRY_COUNT}"
  done

  if [[ "${DEPLOY_HEALTH}" = "${DEPLOY_HEALTH_READY}" ]]; then
    sh_success "The deployment was successful!"
  else
    sh_alert "Exceeded retry-limit (${DEPLOY_RETRY_NUMBER})."
    sh_alert "Deployment Health Status: ${DEPLOY_HEALTH}"
    [[ "${DEPLOY_HEALTH}" = "Red" ]] && sh_fail "The deployment was not successful!"
    sh_alert "The deployment may not have been successful."
  fi
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
  if [[ -z "${1:-}" ]]; then
    sh_error "arg[1] - {{AWS_ACCOUNT_ID}} is required"
    exit 2
  elif [[ -z "${2:-}" ]]; then
    sh_error "arg[2] - {{AWS_ECR_IMAGE_NAME}} is required"
    exit 2
  fi
  AWS_ACCOUNT_ID="${1}"
  AWS_ECR_IMAGE_NAME="${2}"
  AWS_ECR_IMAGE_TAG="${3:-}"
  [[ -z "${AWS_ECR_IMAGE_TAG}" ]] && AWS_ECR_IMAGE_TAG="latest"
  AWS_REGION="${4:-}"
  [[ -z "${AWS_REGION}" ]] && AWS_REGION="us-east-1"

  AWS_ECR_URL=""

  if [ ! -z "$AWS_ACCOUNT_ID" ] && [ ! -z "$AWS_ECR_IMAGE_NAME" ]; then
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

  require_var "LOCAL_FILE_NAME"
  require_var "BUCKET"
  require_func "run_or_fail"

  require_bin "aws" && run_or_fail aws s3 cp ${LOCAL_FILE_NAME} s3://${BUCKET}/${REMOTE_FILE_NAME} ${OPTS}
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

  require_var "SRC_PATH"
  require_var "LOCAL_FILE_NAME"
  require_var "BUCKET"
  require_func "run_or_fail"

  require_bin "zip" && run_or_fail zip ${LOCAL_FILE_NAME} ${SRC_PATH}
  require_func "aws_s3_upload" && run_or_fail aws_s3_upload ${LOCAL_FILE_NAME} ${S3_BUCKET} ${REMOTE_FILE_NAME} ${OPTS}
}
