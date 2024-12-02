const fs = require('fs');

// Function to process versions and trigger workflows
const triggerBuilds = (filePath, versionType) => {
    const newVersions = JSON.parse(fs.readFileSync(filePath, 'utf8'));

    newVersions.forEach(version => {
        if (version.tag) {
            console.log(`Triggering build for GitLab ${versionType} version: ${version.tag}`);

            github.rest.actions.createWorkflowDispatch({
                owner: context.repo.owner,
                repo: context.repo.repo,
                workflow_id: "build.yml",
                ref: "main",
                inputs: {
                    gitlab_release: version.tag,
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
    triggerBuilds('./new_ce_versions.json', 'CE');
}
if (process.env.NEW_BUILD_EE_VERSION_AVAILABLE === 'true') {
    triggerBuilds('./new_ee_versions.json', 'EE');
}