#!/bin/bash
set -eu

cd $(dirname $0)

REFS_TAG=$(git ls-remote --tags https://github.com/aws/aws-cli.git | awk '{print $2}' | grep /1. | grep -v '{}' | sort -rV | head -n1)
CURRENT_AWS_CLI_V1=${REFS_TAG/"refs/tags/"/""}

UPDATED=0
if  ! git ls-remote --tags https://github.com/mmpiotrowski/aws-cli.git | grep -q "${CURRENT_AWS_CLI_V1}"; then
   ./build.sh $CURRENT_AWS_CLI_V1
   ./push.sh $CURRENT_AWS_CLI_V1
   git tag $CURRENT_AWS_CLI_V1
   UPDATED=1
else
   echo "Tag ${CURRENT_AWS_CLI_V1} already exits"
fi

REFS_TAG=$(git ls-remote --tags https://github.com/aws/aws-cli.git | awk '{print $2}' | grep /2. | grep -v '{}' | sort -rV | head -n1)
CURRENT_AWS_CLI_V2=${REFS_TAG/"refs/tags/"/""}


if  ! git ls-remote --tags https://github.com/mmpiotrowski/aws-cli.git | grep -q "${CURRENT_AWS_CLI_V2}"; then
   ./build.sh $CURRENT_AWS_CLI_V2
   ./push.sh $CURRENT_AWS_CLI_V2
   git tag $CURRENT_AWS_CLI_V2
   UPDATED=1

else
   echo "Tag ${CURRENT_AWS_CLI_V2} already exits"
fi

# https://joht.github.io/johtizen/build/2022/01/20/github-actions-push-into-repository.html#example-1
if [ ${UPDATED} != 0 ]; then
   git commit --allow-empty -m "Update aws-cli versions [skip ci]"
   git push && git push --tags
fi