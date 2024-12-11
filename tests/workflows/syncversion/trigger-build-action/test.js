/*
* This file is part of the gitlab-arm64 project.
*
* (c) Festim Kolgeci <festim.kolgei@pm.me>
*
* For complete copyright and license details, please refer
* to the LICENSE file distributed with this source code.
*/
require('./mock-github.js')

const triggerBuilds = require('../../../../scripts/workflows/syncversion/trigger_build_action.js');

console.log(triggerBuilds);

// Check and trigger builds for CE and EE versions
if (process.env.NEW_BUILD_CE_VERSION_AVAILABLE === 'true') {
    triggerBuilds(process.env.NEW_BUILD_CE_VERSIONS, 'CE');
}
if (process.env.NEW_BUILD_EE_VERSION_AVAILABLE === 'true') {
    triggerBuilds(process.env.NEW_BUILD_EE_VERSIONS, 'EE');
}