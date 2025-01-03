#!/bin/bash
#----------------------------------------------------------
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgei@pm.me>
#
# For complete copyright and license details, please refer
# to the LICENSE file distributed with this source code.
#----------------------------------------------------------

set -e

# Get the most recent 'last_updated' for valid release tags
LATEST_CE_LAST_UPDATE=$(jq -r '.[] | select(.name | test("^[0-9]+\\.[0-9]+\\.[0-9]+-ce\\.0$")) | .last_updated' gitlab_tags_ce.json | sort -V | tail -n 1)
LATEST_EE_LAST_UPDATE=$(jq -r '.[] | select(.name | test("^[0-9]+\\.[0-9]+\\.[0-9]+-ee\\.0$")) | .last_updated' gitlab_tags_ee.json | sort -V | tail -n 1)

# Check if jq or the pipeline failed
if [[ $? -ne 0 || -z "$LATEST_CE_LAST_UPDATE" ]]; then
  exit 1
fi
if [[ $? -ne 0 || -z "$LATEST_EE_LAST_UPDATE" ]]; then
  exit 1
fi

echo "LATEST_CE_LAST_UPDATE=$LATEST_CE_LAST_UPDATE" >> "$GITHUB_ENV"
echo "LATEST_EE_LAST_UPDATE=$LATEST_EE_LAST_UPDATE" >> "$GITHUB_ENV"

echo "Latest CE last_update: $LATEST_CE_LAST_UPDATE"
echo "Latest EE last_update: $LATEST_EE_LAST_UPDATE"
