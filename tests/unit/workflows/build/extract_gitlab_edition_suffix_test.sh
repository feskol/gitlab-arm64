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
    bash "../scripts/workflows/build/extract_gitlab_edition_suffix.sh"
}

function test_extract_ce() {
    export INPUT_GITLAB_RELEASE="17.6.1-ce.0"

    runScript

    assert_same "ce" "$(extract_value "GITLAB_EDITION_SUFFIX" "$GITHUB_OUTPUT")"
}

function test_ee_extraction() {
    export INPUT_GITLAB_RELEASE="17.6.1-ee.0"

    runScript

    assert_same "ee" "$(extract_value "GITLAB_EDITION_SUFFIX" "$GITHUB_OUTPUT")"
}
