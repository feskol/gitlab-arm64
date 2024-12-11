/*
* This file is part of the gitlab-arm64 project.
*
* (c) Festim Kolgeci <festim.kolgei@pm.me>
*
* For complete copyright and license details, please refer
* to the LICENSE file distributed with this source code.
*/

// Function to process versions and trigger workflows
const triggerBuilds = (new_version_json, versionType) => {
    const newVersions = JSON.parse(new_version_json);

    newVersions.forEach(version => {
        if (version.tag_name) {
            console.log(`Triggering build for GitLab ${versionType} version: ${version.tag_name}`);

            github.rest.actions.createWorkflowDispatch({
                owner: context.repo.owner,
                repo: context.repo.repo,
                workflow_id: "build.yml",
                ref: "main",
                inputs: {
                    gitlab_release: version.tag_name,
                    include_latest_tags: version.is_latest_overall,
                    include_major_tag: version.is_latest_minor,
                    include_major_minor_tag: version.is_latest_patch
                }
            });
        }
    });
};

// Check and trigger builds for CE and EE versions
if (process.env.NEW_BUILD_CE_VERSION_AVAILABLE === 'true') {
    triggerBuilds(process.env.NEW_BUILD_CE_VERSIONS, 'CE');
}
if (process.env.NEW_BUILD_EE_VERSION_AVAILABLE === 'true') {
    triggerBuilds(process.env.NEW_BUILD_EE_VERSIONS, 'EE');
}