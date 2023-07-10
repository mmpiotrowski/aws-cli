#!/bin/bash
set -eu

cd $(dirname $0)

. settings

AWS_CLI_VERSION="${1}"

docker push "${DOCKERHUB_REPO}":"${AWS_CLI_VERSION}"
