#!/bin/bash
#----------------------------------------------------------
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgei@pm.me>
#
# For complete copyright and license details, please refer
# to the LICENSE file distributed with this source code.
#----------------------------------------------------------

source ./helper/test-case.sh

function cleanup() {
    gitlab_simulation_cleanup
    ./helper/workflows/build/cleanup.sh
}
