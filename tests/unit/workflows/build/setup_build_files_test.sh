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

function set_up_before_script() {
    cleanup
}

function tear_down() {
    cleanup
}

function runScript() {
    # Run original Script
    bash "../scripts/workflows/build/setup_build_files.sh"
}

function test_run_through() {

    export INPUT_GITLAB_RELEASE="17.0.1-ce.0"
    export GITLAB_EDITION_SUFFIX="ce"

    runScript

    assert_exit_code "0"

    assert_file_exists "build/Dockerfile"

    assert_file_exists "build/RELEASE"
    assert_not_empty "$(cat build/RELEASE)"

    assert_equals "DOWNLOAD_URL_arm64=https://packages.gitlab.com/gitlab/gitlab-ce/packages/ubuntu/jammy/gitlab-ce_17.0.1-ce.0_arm64.deb/download.deb" "$(cat build/RELEASE)"
}
