#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

source ./helper/gitlab_simulation.sh

function gitlab_simulation_cleanup() {
    rm -f \
        "$GITHUB_OUTPUT" \
        "$GITHUB_ENV"
}
