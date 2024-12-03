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

function runScript() {
    # Run original Script
    bash "../scripts/workflows/build/validate_input_gitlab_release.sh"
}

function tear_down() {
    cleanup
}

function test_input_valid_ce() {
    export INPUT_GITLAB_RELEASE="17.6.1-ce.0"

    runScript

    assert_exit_code "0"
}

function test_input_valid_ee() {
    export INPUT_GITLAB_RELEASE="17.6.1-ee.0"

    runScript

    assert_exit_code "0"
}

function test_input_whit_whitespace() {
    export INPUT_GITLAB_RELEASE=" 17.6.1-ce.0"

    runScript

    assert_exit_code "0"
}

function test_input_whit_whitespace_2() {
    export INPUT_GITLAB_RELEASE="   17.6.1-ce.0    "

    runScript

    assert_exit_code "0"
}

function test_input_whit_large_versions() {
    export INPUT_GITLAB_RELEASE=" 999.999.999-ce.999"

    runScript

    assert_exit_code "0"
}

function test_input_failure_bad_edition() {
    export INPUT_GITLAB_RELEASE="17.6.1-de.0"

    runScript

    assert_exit_code "1"
}

function test_input_only_major() {
    export INPUT_GITLAB_RELEASE="17"

    runScript

    assert_exit_code "1"
}

function test_input_only_major_minor() {
    export INPUT_GITLAB_RELEASE="17.6"

    runScript

    assert_exit_code "1"
}

function test_input_only_major_minor_patch() {
    export INPUT_GITLAB_RELEASE="17.6.1"

    runScript

    assert_exit_code "1"
}

function test_input_only_major_minor_patch_edition() {
    export INPUT_GITLAB_RELEASE="17.6.1-ce"

    runScript

    assert_exit_code "1"
}

function test_wrong_input() {
    export INPUT_GITLAB_RELEASE="random"

    runScript

    assert_exit_code "1"
}
