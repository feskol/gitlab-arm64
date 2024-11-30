#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

set -e

# Import test-case
source ./helper/test-case.sh

export NEW_BUILD_CE_VERSION_AVAILABLE=$(extract_value "NEW_BUILD_CE_VERSION_AVAILABLE" "GITHUB_OUTPUT")
export NEW_BUILD_EE_VERSION_AVAILABLE=$(extract_value "NEW_BUILD_EE_VERSION_AVAILABLE" "GITHUB_OUTPUT")

# script is javascript so change to correct ORIGINAL_SCRIPT
ORIGINAL_SCRIPT="${ORIGINAL_SCRIPT%.sh}.js"

# Run the original script
node \
  --require "$TEST_DIRECTORY/workflows/syncversion/trigger-build-action/mock-github.js" \
  "$ORIGINAL_SCRIPT"
