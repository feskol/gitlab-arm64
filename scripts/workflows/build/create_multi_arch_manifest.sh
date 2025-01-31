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
# DOCKERHUB_ARM64_IMAGE_TAG
# DOCKERHUB_PUSH_TAGS
# GITLAB_EDITION_SUFFIX
# IS_TEST

# Split the DOCKERHUB_PUSH_TAGS into an array
IFS=',' read -r -a tags <<<"$DOCKERHUB_PUSH_TAGS"

# Loop through each tag and create and push the manifest
for tag in "${tags[@]}"; do
    gitlab_tag="docker.io/gitlab/gitlab-$GITLAB_EDITION_SUFFIX:$INPUT_GITLAB_RELEASE"

    if [ "$IS_TEST" == "false" ]; then
        # Create the manifest
        docker manifest create "$tag" \
            --amend "$DOCKERHUB_ARM64_IMAGE_TAG" \
            --amend "$gitlab_tag"

        # Push the manifest
        docker manifest push -p "$tag"
    else
        echo "[TEST] Create manifest for $tag using arm64-image $DOCKERHUB_ARM64_IMAGE_TAG and the official Gitlab tag $gitlab_tag"
    fi
done
