#!/bin/bash
#----------------------------------------------------------
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgei@pm.me>
#
# For complete copyright and license details, please refer
# to the LICENSE file distributed with this source code.
#----------------------------------------------------------

set -e

### ENVIRONMENT_VARIABLES: ###
# INPUT_GITLAB_RELEASE

validate_version() {
    local version=$1

    # Remove leading and trailing whitespaces
    version=$(echo "$version" | xargs)

    # Regex to match the version format with a 1-digit integer at the end
    local regex='^([0-9]+)\.([0-9]+)\.([0-9]+)-(ce|ee)\.([0-9]+)$'

    if [[ $version =~ $regex ]]; then
        major=${BASH_REMATCH[1]}
        minor=${BASH_REMATCH[2]}
        patch=${BASH_REMATCH[3]}
        edition=${BASH_REMATCH[4]}
        last_digit=${BASH_REMATCH[5]}

        echo "Valid version format."
        echo "  Major: $major"
        echo "  Minor: $minor"
        echo "  Patch: $patch"
        echo "  Edition: $edition"
        echo "  Last digit: $last_digit"

        return 0
    else
        echo "Invalid version format. Expected format: (major).(minor).(patch)-(edition).(single-digit)"
        return 1
    fi
}

validate_version "$INPUT_GITLAB_RELEASE"
