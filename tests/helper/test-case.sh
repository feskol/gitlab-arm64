#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

source ./helper/gitlab_simulation.sh

# shellcheck disable=SC2120
getOriginalScriptPath() {
    local test_script=$1
    echo "$TEST_DIRECTORY/../scripts/$test_script"
}

ORIGINAL_SCRIPT=$(getOriginalScriptPath "$TEST_SCRIPT")
