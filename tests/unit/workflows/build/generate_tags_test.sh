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

function runScript() {
    # Run original Script
    bash "../scripts/workflows/build/generate_tags.sh"
}

function tear_down() {
    cleanup
}

function test_generate_default() {
    export INPUT_GITLAB_RELEASE="17.6.1-ce.0"
    export INPUT_INCLUDE_LATEST_TAGS="false"
    export INPUT_INCLUDE_MAJOR_TAG="false"
    export INPUT_INCLUDE_MAJOR_MINOR_TAG="false"
    export GITLAB_EDITION_SUFFIX="ce"

    runScript

    assert_same "17.6.1-ce.0,17.6.1-ce" "$(extract_value "GENERATED_TAGS" "$GITHUB_ENV")"
}

function test_generate_including_major_minor_tag() {
    export INPUT_GITLAB_RELEASE="17.6.1-ce.0"
    export INPUT_INCLUDE_LATEST_TAGS="false"
    export INPUT_INCLUDE_MAJOR_TAG="false"
    export INPUT_INCLUDE_MAJOR_MINOR_TAG="true"
    export GITLAB_EDITION_SUFFIX="ce"

    runScript

    assert_same "17.6.1-ce.0,17.6.1-ce,17.6-ce" "$(extract_value "GENERATED_TAGS" "$GITHUB_ENV")"
}

function test_generate_including_major_tag() {
    export INPUT_GITLAB_RELEASE="17.6.1-ce.0"
    export INPUT_INCLUDE_LATEST_TAGS="false"
    export INPUT_INCLUDE_MAJOR_TAG="true"
    export INPUT_INCLUDE_MAJOR_MINOR_TAG="false"
    export GITLAB_EDITION_SUFFIX="ce"

    runScript

    assert_same "17.6.1-ce.0,17.6.1-ce,17-ce" "$(extract_value "GENERATED_TAGS" "$GITHUB_ENV")"
}

function test_generate_including_latest_tag_for_ce() {
    export INPUT_GITLAB_RELEASE="17.6.1-ce.0"
    export INPUT_INCLUDE_LATEST_TAGS="true"
    export INPUT_INCLUDE_MAJOR_TAG="false"
    export INPUT_INCLUDE_MAJOR_MINOR_TAG="false"
    export GITLAB_EDITION_SUFFIX="ce"

    runScript

    assert_same "17.6.1-ce.0,17.6.1-ce,ce,latest" "$(extract_value "GENERATED_TAGS" "$GITHUB_ENV")"
}

function test_generate_including_latest_tag_for_ee() {
    export INPUT_GITLAB_RELEASE="17.6.1-ee.0"
    export INPUT_INCLUDE_LATEST_TAGS="true"
    export INPUT_INCLUDE_MAJOR_TAG="false"
    export INPUT_INCLUDE_MAJOR_MINOR_TAG="false"
    export GITLAB_EDITION_SUFFIX="ee"

    runScript

    assert_same "17.6.1-ee.0,17.6.1-ee,ee" "$(extract_value "GENERATED_TAGS" "$GITHUB_ENV")"
}

function test_generate_all_together_for_ce() {
    export INPUT_GITLAB_RELEASE="17.6.1-ce.0"
    export INPUT_INCLUDE_LATEST_TAGS="true"
    export INPUT_INCLUDE_MAJOR_TAG="true"
    export INPUT_INCLUDE_MAJOR_MINOR_TAG="true"
    export GITLAB_EDITION_SUFFIX="ce"

    runScript

    assert_same "17.6.1-ce.0,17.6.1-ce,17.6-ce,17-ce,ce,latest" "$(extract_value "GENERATED_TAGS" "$GITHUB_ENV")"
}

function test_generate_all_together_for_ee() {
    export INPUT_GITLAB_RELEASE="17.6.1-ee.0"
    export INPUT_INCLUDE_LATEST_TAGS="true"
    export INPUT_INCLUDE_MAJOR_TAG="true"
    export INPUT_INCLUDE_MAJOR_MINOR_TAG="true"
    export GITLAB_EDITION_SUFFIX="ee"

    runScript

    assert_same "17.6.1-ee.0,17.6.1-ee,17.6-ee,17-ee,ee" "$(extract_value "GENERATED_TAGS" "$GITHUB_ENV")"
}
