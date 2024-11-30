#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

set -e

# Import test-case
source ./helper/test-case.sh

# Run the original script
bash $ORIGINAL_SCRIPT
