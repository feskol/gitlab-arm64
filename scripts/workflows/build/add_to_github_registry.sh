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
# REGISTRY
# REPOSITORY
# IMAGE_NAME
# ALL_DOCKERHUB_TAGS
# IS_TEST

# Convert comma-separated string into an array
IFS=',' read -ra images <<< "$ALL_DOCKERHUB_TAGS"

for docker_image in "${images[@]}"; do
    tag="${docker_image##*:}" # Extracts the tag (everything after the last ':')
    ghcr_image="$REGISTRY/$REPOSITORY/$IMAGE_NAME:$tag"

    if [ "$IS_TEST" == "false" ]; then
        # Copy and push multi-arch manifest to GitHub Container Registry
        docker buildx imagetools create --tag "$ghcr_image" "$docker_image"
    else
        echo "[TEST] Pulled and pushing multiarch image "$tag":  $docker_image -> $ghcr_image"
    fi
done
