#!/bin/bash
#----------------------------------------------------------
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgei@pm.me>
#
# For complete copyright and license details, please refer
# to the LICENSE file distributed with this source code.
#----------------------------------------------------------

# Simulate GitHub Actions environment locally
if [ -z "$GITHUB_OUTPUT" ]; then
    GITHUB_OUTPUT=./GITHUB_OUTPUT_SIMULATION
    export GITHUB_OUTPUT
fi

if [ -z "$GITHUB_ENV" ]; then
    GITHUB_ENV=./GITHUB_ENV_SIMULATION
    export GITHUB_ENV
fi

# Function to extract the value from $GITHUB_OUTPUT or GITHUB_ENV files
extract_value() {
    local var_name="$1"
    local file="$2"

    awk -v var="$var_name" '
        BEGIN { found = 0; result = "" }
        $0 ~ "^" var "=" {
            # Single-line case: var=value
            found = 1
            sub("^" var "=", "", $0)
            print $0
            exit
        }
        $0 == var "<<EOF" {
            # Multiline case: var<<EOF ... EOF
            found = 2
            next
        }
        found == 2 && $0 == "EOF" {
            print result
            exit
        }
        found == 2 {
            result = result $0 "\n"
        }
    ' "$file"
}
