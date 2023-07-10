#!/bin/bash
set -eu

cd $(dirname $0)

. settings

AWS_CLI_VERSION="${1}"

AWS_CLI_MAJOR=$(echo "${AWS_CLI_VERSION}" | cut -d '.' -f 1)

if [ $AWS_CLI_MAJOR -gt 1 ]; then
  BUILD_DIR="aws-cli-v2"
else
  BUILD_DIR="aws-cli-v1"
fi;

docker build \
  --build-arg AWS_CLI_VERSION="${AWS_CLI_VERSION}" \
  -t "${DOCKERHUB_REPO}":"${AWS_CLI_VERSION}" \
  "${BUILD_DIR}"

