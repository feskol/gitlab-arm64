#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

source ./helper/test-case.sh

function cleanup() {
    gitlab_simulation_cleanup
    ./helper/workflows/build/cleanup.sh
}
