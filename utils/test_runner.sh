#!/usr/bin/env bash

set -eo pipefail

BUILD_ID=${BUILD_ID}
TEAMCITY_TOKEN=${TEAMCITY_TOKEN}
GITHUB_REF=${GITHUB_REF}
COMMENT=${COMMENT}

if [ -z "$BUILD_ID" ]; then
  echo "Unable to find BUILD_ID environment variable, abort!"
  exit 1
fi

if [ -z "$TEAMCITY_TOKEN" ]; then
  echo "Unable to find TEAMCITY_TOKEN environment variable, abort!"
  exit 1
fi

if [ -z "$GITHUB_REF" ]; then
  echo "Unable to find GITHUB_REF environment variable, abort!"
  exit 1
fi

if [ -z "$COMMENT" ]; then
  echo "Empty comment"
fi

echo "<build branchName=\"$GITHUB_REF\"><buildType id=\"${BUILD_ID}\"/><change locator=\"version:$GITHUB_SHA,buildType:(id:$BUILD_ID)\"/>${COMMENT}</build>" >api_build.xml
curl -f https://teamcity.supplyshift.net/app/rest/buildQueue -X POST -H "Content-Type:application/xml" -H "Authorization:Bearer ${TEAMCITY_TOKEN}" --data-binary @api_build.xml
