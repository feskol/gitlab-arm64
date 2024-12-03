#!/bin/bash
#----------------------------------------------------------
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgei@pm.me>
#
# For complete copyright and license details, please refer
# to the LICENSE file distributed with this source code.
#----------------------------------------------------------

# Import test-case
source ./helper/workflows/build/test-case.sh

function tear_down() {
    cleanup
}

function runScript() {
    # Run original Script
    bash "../scripts/workflows/build/setup_build_files.sh"
}

function test_run_through() {

    export INPUT_GITLAB_RELEASE="17.0.1-ce.0"

    runScript

    assert_exit_code "0"

    assert_file_exists "build/Dockerfile"

    assert_file_exists "build/RELEASE"
    assert_not_empty "$(cat build/RELEASE))"

}
