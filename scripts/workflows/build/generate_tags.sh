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

### ENVIRONMENT_VARIABLES: ###
# INPUT_GITLAB_RELEASE
# INPUT_INCLUDE_LATEST_TAGS
# INPUT_INCLUDE_MAJOR_TAG
# INPUT_INCLUDE_MAJOR_MINOR_TAG
# GITLAB_EDITION_SUFFIX

# Extract GitLab Edition suffix (ce or ee)
SUFFIX="$GITLAB_EDITION_SUFFIX"

# Strip version-specific parts to generate base tags
BASE_TAG=$(echo "$INPUT_GITLAB_RELEASE" | sed -E "s/-${SUFFIX}.0$//")
TAG_MAJOR=$(echo "$BASE_TAG" | cut -d. -f1)
TAG_MAJOR_MINOR=$(echo "$BASE_TAG" | cut -d. -f1-2)
TAG_MAJOR_MINOR_PATCH=$(echo "$BASE_TAG" | cut -d. -f1-3)

# Add default tag
DEFAULT_TAGS="$INPUT_GITLAB_RELEASE $TAG_MAJOR_MINOR_PATCH-$SUFFIX"

# include major.minor tag
if [ "$INPUT_INCLUDE_MAJOR_MINOR_TAG" == "true" ]; then
    DEFAULT_TAGS="$DEFAULT_TAGS $TAG_MAJOR_MINOR-$SUFFIX"
fi

# include major tag
if [ "$INPUT_INCLUDE_MAJOR_TAG" == "true" ]; then
    DEFAULT_TAGS="$DEFAULT_TAGS $TAG_MAJOR-$SUFFIX"
fi

# include latest tags
if [ "$INPUT_INCLUDE_LATEST_TAGS" == "true" ]; then
    DEFAULT_TAGS="$DEFAULT_TAGS $SUFFIX"

    if [ "$SUFFIX" == "ce" ]; then
        DEFAULT_TAGS="$DEFAULT_TAGS latest"
    fi
fi

# Combine all tags, ensuring no extra spaces
ALL_TAGS="$DEFAULT_TAGS"

# Replace spaces with comma
ALL_TAGS=$(echo "$ALL_TAGS" | tr ' ' ',')

echo "GENERATED_TAGS=$ALL_TAGS" >> "$GITHUB_ENV"
echo "Gernerated tags: $ALL_TAGS"

# Define docker image tag for arm64 image
DOCKER_IMAGE_TAG="$INPUT_GITLAB_RELEASE-arm64"
echo "ARM64_IMAGE_TAG=$DOCKER_IMAGE_TAG" >> "$GITHUB_ENV"
echo "ARM64 image tag: $DOCKER_IMAGE_TAG"
