#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

set -e

# Import test-case
source ./helper/test-case.sh

# Define ENV variables
export LATEST_CE_LAST_UPDATE=$(extract_value "LATEST_CE_LAST_UPDATE" "GITHUB_OUTPUT")
export LATEST_EE_LAST_UPDATE=$(extract_value "LATEST_EE_LAST_UPDATE" "GITHUB_OUTPUT")

# Run the original script
bash $ORIGINAL_SCRIPT
