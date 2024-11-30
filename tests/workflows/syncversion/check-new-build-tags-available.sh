#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

set -e

# Import helper
source ./helper/gitlab_simulation.sh

# Run the original script
./$ORIGINAL_SCRIPT
