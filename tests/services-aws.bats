#!/usr/bin/env bats

. "${BATS_TEST_DIRNAME}/../scripts/support.sh"

@test "'aws_docker_login' should exist and work as expected" {
  run type aws_docker_login
  [ "$status" -eq 0 ]
  run echo $(aws_docker_login)
  [ "$output" = "$output" ]
}

@test "'aws_docker_push' should exist and work as expected" {
  run type aws_docker_push
  [ "$status" -eq 0 ]
  run echo $(aws_docker_push)
  [ "$output" = "$output" ]
  run echo $(aws_docker_push "AWS_ECR_IMAGE_URL")
  [ "$output" = "$output" ]
  run echo $(aws_docker_push "AWS_ECR_IMAGE_URL" "us-east-1")
  [ "$output" = "$output" ]
  run echo $(aws_docker_push "AWS_ECR_IMAGE_URL" "us-east-1" "yes")
  [ "$output" = "$output" ]
}

@test "'aws_eb_create' should exist and work as expected" {
  run type aws_eb_create
  [ "$status" -eq 0 ]
  run echo $(aws_eb_create)
  [ "$output" = "$output" ]
  run echo $(aws_eb_create "APP_NAME")
  [ "$output" = "$output" ]
  run echo $(aws_eb_create "APP_NAME" "latest")
  [ "$output" = "$output" ]
  run echo $(aws_eb_create "APP_NAME" "latest" "AWS_S3_BUCKET")
  [ "$output" = "$output" ]
  run echo $(aws_eb_create "APP_NAME" "latest" "AWS_S3_BUCKET" "AWS_S3_URI.zip")
  [ "$output" = "$output" ]
}

@test "'aws_eb_health_check' should exist and work as expected" {
  run type aws_eb_health_check
  [ "$status" -eq 0 ]
  run echo $(aws_eb_health_check)
  [ "$output" = "$output" ]
  run echo $(aws_eb_health_check "APP_NAME_ENV")
  [ "$output" = "$output" ]
  run echo $(aws_eb_health_check "APP_NAME_ENV" "1")
  [ "$output" = "$output" ]
  run echo $(aws_eb_health_check "APP_NAME_ENV" "1" "1")
  [ "$output" = "$output" ]
}

@test "'aws_eb_update' should exist and work as expected" {
  run type aws_eb_update
  [ "$status" -eq 0 ]
  run echo $(aws_eb_update)
  [ "$output" = "$output" ]
  run echo $(aws_eb_update "APP_NAME")
  [ "$output" = "$output" ]
  run echo $(aws_eb_update "APP_NAME" "latest")
  [ "$output" = "$output" ]
  run echo $(aws_eb_update "APP_NAME" "latest" "APP_NAME_ENV")
  [ "$output" = "$output" ]
}

@test "'aws_ecr_url' should exist and work as expected" {
  run type aws_ecr_url
  [ "$status" -eq 0 ]
  run echo $(aws_ecr_url)
  [ "$output" = "$output" ]
  run echo $(aws_ecr_url "AWS_ACCOUNT_ID")
  [ "$output" = "$output" ]
  run echo $(aws_ecr_url "AWS_ACCOUNT_ID" "AWS_ECR_IMAGE_NAME")
  [ "$output" = "$output" ]
  run echo $(aws_ecr_url "AWS_ACCOUNT_ID" "AWS_ECR_IMAGE_NAME" "AWS_ECR_IMAGE_TAG")
  [ "$output" = "$output" ]
  run echo $(aws_ecr_url "AWS_ACCOUNT_ID" "AWS_ECR_IMAGE_NAME" "AWS_ECR_IMAGE_TAG" "AWS_REGION")
  [ "$output" = "$output" ]
}

@test "'aws_s3_upload' should exist and work as expected" {
  run type aws_s3_upload
  [ "$status" -eq 0 ]
  run echo $(aws_s3_upload)
  [ "$output" = "$output" ]
  run echo $(aws_s3_upload "LOCAL_FILE_NAME")
  [ "$output" = "$output" ]
  run echo $(aws_s3_upload "LOCAL_FILE_NAME" "AWS_S3_BUCKET")
  [ "$output" = "$output" ]
  run echo $(aws_s3_upload "LOCAL_FILE_NAME" "AWS_S3_BUCKET" "REMOTE_FILE_NAME")
  [ "$output" = "$output" ]
  run echo $(aws_s3_upload "LOCAL_FILE_NAME" "AWS_S3_BUCKET" "REMOTE_FILE_NAME" "OPTS")
  [ "$output" = "$output" ]
}

@test "'aws_s3_zip_upload' should exist and work as expected" {
  run type aws_s3_zip_upload
  [ "$status" -eq 0 ]
  run echo $(aws_s3_zip_upload)
  [ "$output" = "$output" ]
  run echo $(aws_s3_zip_upload "SRC_PATH")
  [ "$output" = "$output" ]
  run echo $(aws_s3_zip_upload "SRC_PATH" "LOCAL_FILE_NAME")
  [ "$output" = "$output" ]
  run echo $(aws_s3_zip_upload "SRC_PATH" "LOCAL_FILE_NAME" "AWS_S3_BUCKET")
  [ "$output" = "$output" ]
  run echo $(aws_s3_zip_upload "SRC_PATH" "LOCAL_FILE_NAME" "AWS_S3_BUCKET" "REMOTE_FILE_NAME")
  [ "$output" = "$output" ]
  run echo $(aws_s3_zip_upload "SRC_PATH" "LOCAL_FILE_NAME" "AWS_S3_BUCKET" "REMOTE_FILE_NAME" "OPTS")
  [ "$output" = "$output" ]
}
