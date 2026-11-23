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
# MANIFEST_TAGS
# OFFICIAL_GITLAB_IMAGE
# IS_TEST

# Split the DOCKERHUB_PUSH_TAGS into an array
IFS=',' read -r -a tags <<<"$MANIFEST_TAGS"

# Loop through each tag and create and push the manifest
for tag in "${tags[@]}"; do
    if [ "$IS_TEST" == "false" ]; then
        # Create + push the custom tag using the official Gitlab-Image manifest
        docker buildx imagetools create \
            --tag "$tag" \
            "$OFFICIAL_GITLAB_IMAGE"
    else
        echo "[TEST] Create manifest for $tag using the official multi-arch Gitlab image $OFFICIAL_GITLAB_IMAGE"
    fi
done
