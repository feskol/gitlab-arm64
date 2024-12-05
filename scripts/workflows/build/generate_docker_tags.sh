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
# GENERATED_TAGS
# DOCKERHUB_USERNAME

DOCKERHUB_PUSH_TAGS=$(echo "$GENERATED_TAGS" | tr ',' '\n' | xargs -I {} echo "docker.io/${DOCKERHUB_USERNAME}/gitlab:{}" | paste -sd, -)
echo "DOCKERHUB_PUSH_TAGS=${DOCKERHUB_PUSH_TAGS}" >> "$GITHUB_ENV"

DOCKERHUB_PUSH_ORIGINAL_TAG="docker.io/${DOCKERHUB_USERNAME}/gitlab:${INPUT_GITLAB_RELEASE}"
echo "DOCKERHUB_PUSH_ORIGINAL_TAG=${DOCKERHUB_PUSH_ORIGINAL_TAG}" >> "$GITHUB_ENV"
