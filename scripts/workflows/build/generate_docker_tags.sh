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

DOCKERHUB_PUSH_TAGS=$(echo "$GENERATED_TAGS" | tr ',' '\n' | xargs -I {} echo "docker.io/${DOCKERHUB_USERNAME}/gitlab:{}" | paste -sd, -)
echo "DOCKERHUB_PUSH_TAGS=${DOCKERHUB_PUSH_TAGS}" >> "$GITHUB_ENV"
