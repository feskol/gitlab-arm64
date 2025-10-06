#!/bin/bash
#----------------------------------------------------------
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgei@pm.me>
#
# For complete copyright and license details, please refer
# to the LICENSE file distributed with this source code.
#----------------------------------------------------------

source ./helper/gitlab_simulation.sh

function gitlab_simulation_cleanup() {
    rm -f \
        "$GITHUB_OUTPUT" \
        "$GITHUB_ENV"
}
