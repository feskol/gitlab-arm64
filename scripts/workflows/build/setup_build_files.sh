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
# GITLAB_EDITION_SUFFIX

# Replace "-" with "+" in the release
GITLAB_OMNIBUS_RELEASE="${INPUT_GITLAB_RELEASE//-/+}"

# creat build directory
mkdir -p build

# Download original GitLab-Omnibus Docker setup files
omnibus_link="https://gitlab.com/gitlab-org/omnibus-gitlab/-/archive/${GITLAB_OMNIBUS_RELEASE}/omnibus-gitlab-${GITLAB_OMNIBUS_RELEASE}.tar.gz"
curl -sL "$omnibus_link" | tar xz --strip-components=2 -C build "omnibus-gitlab-${GITLAB_OMNIBUS_RELEASE}/docker"

echo "Downloaded GitLab-Omnibus Docker setup files"

# Create RELEASE file
RELEASE_PACKAGE="gitlab-$GITLAB_EDITION_SUFFIX"
RELEASE_VERSION="$INPUT_GITLAB_RELEASE"

echo "DOWNLOAD_URL_arm64=https://packages.gitlab.com/gitlab/${RELEASE_PACKAGE}/packages/ubuntu/jammy/${RELEASE_PACKAGE}_${RELEASE_VERSION}_arm64.deb/download.deb" >> build/RELEASE

echo "Created RELEASE file"
cat build/RELEASE

tree -ah build
