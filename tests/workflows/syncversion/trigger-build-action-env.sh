#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

# Import helper
source ./helper/gitlab_simulation.sh

export NEW_BUILD_CE_VERSION_AVAILABLE=$(extract_value "NEW_BUILD_CE_VERSION_AVAILABLE" "GITHUB_OUTPUT")
export NEW_BUILD_EE_VERSION_AVAILABLE=$(extract_value "NEW_BUILD_EE_VERSION_AVAILABLE" "GITHUB_OUTPUT")
