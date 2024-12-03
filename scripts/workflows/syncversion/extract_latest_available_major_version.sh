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

# Extract the tags from the JSON data, filter based on the pattern, and sort them by version number (major, minor, patch).
latest_ce_tag=$(jq -r '.[] | select(.name | test("^[0-9]+\\.[0-9]+\\.[0-9]+-ce\\.0$")) | .name' gitlab_tags_ce.json | sort -V | tail -n 1)
latest_ee_tag=$(jq -r '.[] | select(.name | test("^[0-9]+\\.[0-9]+\\.[0-9]+-ee\\.0$")) | .name' gitlab_tags_ee.json | sort -V | tail -n 1)

# Check if jq or the pipeline failed
if [[ $? -ne 0 || -z "$latest_ce_tag" ]]; then
  exit 1
fi
if [[ $? -ne 0 || -z "$latest_ee_tag" ]]; then
  exit 1
fi

# Strip version-specific parts to generate base tags
BASE_TAG_CE=$(echo "$latest_ce_tag" | sed -E "s/-ce.0$//")
BASE_TAG_EE=$(echo "$latest_ee_tag" | sed -E "s/-ee.0$//")

# Read the highest version tag
LATEST_MAJOR_CE=$(echo "$BASE_TAG_CE" | cut -d. -f1)
LATEST_MAJOR_EE=$(echo "$BASE_TAG_EE" | cut -d. -f1)

echo "LATEST_MAJOR_CE=$LATEST_MAJOR_CE" >> "$GITHUB_OUTPUT"
echo "LATEST_MAJOR_EE=$LATEST_MAJOR_EE" >> "$GITHUB_OUTPUT"

# Output major
echo "CE latest major: $LATEST_MAJOR_CE"
echo "EE latest major: $LATEST_MAJOR_EE"

# Read the highest major.minor
LATEST_MAJOR_MINOR_CE=$(echo "$BASE_TAG_CE" | cut -d. -f1-2)
LATEST_MAJOR_MINOR_EE=$(echo "$BASE_TAG_EE" | cut -d. -f1-2)

echo "LATEST_MAJOR_MINOR_CE=$LATEST_MAJOR_MINOR_CE" >> "$GITHUB_OUTPUT"
echo "LATEST_MAJOR_MINOR_EE=$LATEST_MAJOR_MINOR_EE" >> "$GITHUB_OUTPUT"

# Output major.minor
echo "CE latest major.minor: $LATEST_MAJOR_MINOR_CE"
echo "EE latest major.minor: $LATEST_MAJOR_MINOR_EE"
