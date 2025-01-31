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
# GENERATED_TAGS
# ARM64_IMAGE_TAG
# DOCKER_IMAGE
# GITHUB_IMAGE

generate_tags(){
    local platform="$1"
    local image="$2"

    # Generate manifest tags
    PLATFORM_MANIFEST_TAGS=$(echo "$GENERATED_TAGS" | tr ',' '\n' | xargs -I {} echo "${image}:{}" | paste -sd, -)
    echo "${platform}_MANIFEST_TAGS=${PLATFORM_MANIFEST_TAGS}" >> "$GITHUB_OUTPUT"

    # Generate arm64 image tag
    PLATFORM_ARM64_IMAGE_TAG="${image}:$ARM64_IMAGE_TAG"
    echo "${platform}_ARM64_IMAGE_TAG=${PLATFORM_ARM64_IMAGE_TAG}" >> "$GITHUB_OUTPUT"
}

generate_tags "DOCKERHUB" "$DOCKER_IMAGE"
generate_tags "GITHUB" "$GITHUB_IMAGE"
