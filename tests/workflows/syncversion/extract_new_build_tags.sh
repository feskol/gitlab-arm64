#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

set -e

# Import helper
source ./helper/gitlab_simulation.sh

# Define ENV variables
export SAVED_CE_LAST_MODIFIED_DATE=$(extract_value "SAVED_CE_LAST_MODIFIED_DATE" "GITHUB_OUTPUT")
export SAVED_EE_LAST_MODIFIED_DATE=$(extract_value "SAVED_EE_LAST_MODIFIED_DATE" "GITHUB_OUTPUT")
export LATEST_MAJOR_CE=$(extract_value "LATEST_MAJOR_CE" "GITHUB_OUTPUT")
export LATEST_MAJOR_MINOR_CE=$(extract_value "LATEST_MAJOR_MINOR_CE" "GITHUB_OUTPUT")
export LATEST_MAJOR_EE=$(extract_value "LATEST_MAJOR_EE" "GITHUB_OUTPUT")
export LATEST_MAJOR_MINOR_EE=$(extract_value "LATEST_MAJOR_MINOR_EE" "GITHUB_OUTPUT")

# Run the original script
./$ORIGINAL_SCRIPT
