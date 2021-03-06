#!/usr/bin/env bash

set -e

export GITHUB_USER=akolov
export GITHUB_REPO=AutolayoutHelper
export GITHUB_TOKEN=$(cat ~/.github_token)

PRODUCT_NAME=AutolayoutHelper
TAG=$1

carthage build --no-skip-current --platform iOS
carthage archive --project-directory .

git tag -a -m "$TAG release" $TAG
git push --tags

PRODUCT_FILE=$PRODUCT_NAME.framework.zip
github-release release --tag $TAG
github-release upload --tag $TAG --file $PRODUCT_FILE --name $PRODUCT_FILE

rm -f $PRODUCT_FILE
