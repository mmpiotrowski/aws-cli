#!/bin/bash
set -eu

cd $(dirname $0)

REFS_TAG=$(git ls-remote --tags https://github.com/aws/aws-cli.git | awk '{print $2}' | grep /1. | grep -v '{}' | sort -rV | head -n1)
CURRENT_AWS_CLI_V1=${REFS_TAG/"refs/tags/"/""}

./build.sh $CURRENT_AWS_CLI_V1

if ! git tag --contains | grep -q ${CURRENT_AWS_CLI_V1}; then
   git tag $CURRENT_AWS_CLI_V1
fi


REFS_TAG=$(git ls-remote --tags https://github.com/aws/aws-cli.git | awk '{print $2}' | grep /2. | grep -v '{}' | sort -rV | head -n2)
CURRENT_AWS_CLI_V2=${REFS_TAG/"refs/tags/"/""}

./build.sh $CURRENT_AWS_CLI_V2

if ! git tag --contains | grep -q ${CURRENT_AWS_CLI_V2}; then
   git tag $CURRENT_AWS_CLI_V2
fi

git push --tags