#!/bin/bash
#----------------------------------------------------------
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgei@pm.me>
#
# For complete copyright and license details, please refer
# to the LICENSE file distributed with this source code.
#----------------------------------------------------------

# Cleanup files
rm -f \
    gitlab_tags_ce.json \
    gitlab_tags_ee.json \
    new_ce_versions.json \
    new_ee_versions.json \
    own_tags.txt

# Cleanup directories
rm -rf .github
