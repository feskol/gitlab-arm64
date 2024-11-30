#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

# Cleanup files
rm -f \
    "$GITHUB_OUTPUT" \
    "$GITHUB_ENV" \
    gitlab_tags_ce.json \
    gitlab_tags_ee.json \
    new_ce_versions.json \
    new_ee_versions.json \
    own_tags.txt

# Cleanup directories
rm -rf .github
