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

# Extract GitLab Edition (-ce or -ee)
EDITION_SUFFIX=$(echo "$INPUT_GITLAB_RELEASE" | sed -E 's/.*-(ce|ee).*/\1/')
echo "GITLAB_EDITION_SUFFIX=$EDITION_SUFFIX" >> "$GITHUB_ENV"
