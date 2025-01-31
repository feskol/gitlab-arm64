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
# DOCKERHUB_USERNAME
# ARM64_IMAGE_TAG

DOCKERHUB_MANIFEST_TAGS=$(echo "$GENERATED_TAGS" | tr ',' '\n' | xargs -I {} echo "docker.io/${DOCKERHUB_USERNAME}/gitlab:{}" | paste -sd, -)
echo "DOCKERHUB_MANIFEST_TAGS=${DOCKERHUB_MANIFEST_TAGS}" >> "$GITHUB_OUTPUT"

DOCKERHUB_ARM64_IMAGE_TAG="docker.io/${DOCKERHUB_USERNAME}/gitlab:$ARM64_IMAGE_TAG"
echo "DOCKERHUB_ARM64_IMAGE_TAG=${DOCKERHUB_ARM64_IMAGE_TAG}" >> "$GITHUB_OUTPUT"
