#!/bin/bash
set -eux

GITHUB_ACTION=${GITHUB_ACTION:-""}


cd $(dirname $0)

REFS_TAG=$(git ls-remote --tags https://github.com/aws/aws-cli.git | awk '{print $2}' | grep /1. | grep -v '{}' | sort -rV | head -n1)
CURRENT_AWS_CLI_V1=${REFS_TAG/"refs/tags/"/""}

./build.sh $CURRENT_AWS_CLI_V1

UPDATED=0
if ! git tag -l | grep -q ${CURRENT_AWS_CLI_V1}; then
   git tag $CURRENT_AWS_CLI_V1
   UPDATED=1
fi


REFS_TAG=$(git ls-remote --tags https://github.com/aws/aws-cli.git | awk '{print $2}' | grep /2. | grep -v '{}' | sort -rV | head -n1)
CURRENT_AWS_CLI_V2=${REFS_TAG/"refs/tags/"/""}

./build.sh $CURRENT_AWS_CLI_V2

if ! git tag -l | grep -q ${CURRENT_AWS_CLI_V2}; then
   git tag $CURRENT_AWS_CLI_V2
   UPDATED=1
fi

# https://joht.github.io/johtizen/build/2022/01/20/github-actions-push-into-repository.html#example-1
if [ ${UPDATED} != 0 ]; then
    git commit --allow-empty -m "Update aws-cli versions"
    if [ ! -z ${GITHUB_ACTION} ]; then
        git config --global user.name "${{ env.CI_COMMIT_AUTHOR }}"
        git config --global user.email "workflows@github.com"
    fi
    git push && git push --tags
fi