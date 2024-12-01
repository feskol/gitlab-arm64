#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

source ./helper/test-case.sh

function cleanup() {
    ./helper/workflows/syncversion/cleanup.sh
}

function fixture_path() {
    local file_or_path="$1"

    echo "./fixtures/workflows/syncversion/$file_or_path"
}
