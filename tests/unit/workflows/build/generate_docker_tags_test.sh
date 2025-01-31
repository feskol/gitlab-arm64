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
    bash "../scripts/workflows/build/generate_docker_tags.sh"
}

function test_generate_docker_tags() {
    export GENERATED_TAGS="17.6.1-ce.0,17.6.1-ce,17.6-ce,17-ce,ce,latest"
    export ARM64_IMAGE_TAG="17.6.1-ce.0-arm64"
    export DOCKER_IMAGE="docker.io/randomtestusername/gitlab"
    export GITHUB_IMAGE="ghcr.io/mygithubuser/gitlab"

    runScript

    local tag1="docker.io/randomtestusername/gitlab:17.6.1-ce.0"
    local tag2="docker.io/randomtestusername/gitlab:17.6.1-ce"
    local tag3="docker.io/randomtestusername/gitlab:17.6-ce"
    local tag4="docker.io/randomtestusername/gitlab:17-ce"
    local tag5="docker.io/randomtestusername/gitlab:ce"
    local tag6="docker.io/randomtestusername/gitlab:latest"

    assert_same "$tag1,$tag2,$tag3,$tag4,$tag5,$tag6" "$(extract_value "DOCKERHUB_MANIFEST_TAGS" "$GITHUB_OUTPUT")"

    assert_same "docker.io/randomtestusername/gitlab:17.6.1-ce.0-arm64" "$(extract_value "DOCKERHUB_ARM64_IMAGE_TAG" "$GITHUB_OUTPUT")"
    assert_same "ghcr.io/mygithubuser/gitlab:17.6.1-ce.0-arm64" "$(extract_value "GITHUB_ARM64_IMAGE_TAG" "$GITHUB_OUTPUT")"
}
