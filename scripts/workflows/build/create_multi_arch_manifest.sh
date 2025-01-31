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
# GITLAB_EDITION_SUFFIX
# ARM64_IMAGE_TAG
# MANIFEST_TAGS
# IS_TEST

# Split the DOCKERHUB_PUSH_TAGS into an array
IFS=',' read -r -a tags <<<"$MANIFEST_TAGS"

# Loop through each tag and create and push the manifest
for tag in "${tags[@]}"; do
    gitlab_tag="docker.io/gitlab/gitlab-$GITLAB_EDITION_SUFFIX:$INPUT_GITLAB_RELEASE"

    if [ "$IS_TEST" == "false" ]; then
        # Create the manifest
        docker manifest create "$tag" \
            --amend "$ARM64_IMAGE_TAG" \
            --amend "$gitlab_tag"

        # Push the manifest
        docker manifest push -p "$tag"
    else
        echo "[TEST] Create manifest for $tag using arm64-image $ARM64_IMAGE_TAG and the official Gitlab tag $gitlab_tag"
    fi
done
