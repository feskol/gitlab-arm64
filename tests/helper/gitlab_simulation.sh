#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

# Simulate GitHub Actions environment locally
if [ -z "$GITHUB_OUTPUT" ]; then
    GITHUB_OUTPUT=./GITHUB_OUTPUT
    export GITHUB_OUTPUT
fi

if [ -z "$GITHUB_ENV" ]; then
    GITHUB_ENV=./GITHUB_ENV
    export GITHUB_ENV
fi

# Function to extract the value from $GITHUB_OUTPUT or GITHUB_ENV files
extract_value() {
    local name=$1
    local file=$2

    # Extract the value from the file, using grep and cut to get the value
    grep -E "^$name=" "$file" | tail -n 1 | cut -d '=' -f2-
}
