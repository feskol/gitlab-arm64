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
    bash "../scripts/workflows/build/create_multi_arch_manifest_official_manifest.sh"
}

function test_gitlab_tag_building() {
    local tag1="docker.io/randomusername/gitlab:17.6.1-ce.0"
    local tag2="docker.io/randomusername/gitlab:17.6.1-ce"
    local tag3="docker.io/randomusername/gitlab:17.6-ce"
    local tag4="docker.io/randomusername/gitlab:17-ce"
    local tag5="docker.io/randomusername/gitlab:ce"
    local tag6="docker.io/randomusername/gitlab:latest"

    export MANIFEST_TAGS="$tag1,$tag2,$tag3,$tag4,$tag5,$tag6"
    export ARM64_IMAGE_TAG="docker.io/randomusername/gitlab:17.6.1-ce.0-arm64"
    export OFFICIAL_GITLAB_IMAGE="docker.io/gitlab/gitlab-ce:17.6.1-ce.0"
    export IS_TEST="true"

    response=$(runScript)

    assert_contains "docker.io/gitlab/gitlab-ce:17.6.1-ce.0" "$response"

    assert_contains "docker.io/randomusername/gitlab:17.6.1-ce.0" "$response"
    assert_contains "docker.io/randomusername/gitlab:17.6.1-ce" "$response"
    assert_contains "docker.io/randomusername/gitlab:17.6-ce" "$response"
    assert_contains "docker.io/randomusername/gitlab:17-ce" "$response"
    assert_contains "docker.io/randomusername/gitlab:ce" "$response"
    assert_contains "docker.io/randomusername/gitlab:latest" "$response"
}
