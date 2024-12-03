/*
* This file is part of the gitlab-arm64 project.
*
* (c) Festim Kolgeci <festim.kolgei@pm.me>
*
* For complete copyright and license details, please refer
* to the LICENSE file distributed with this source code.
*/

global.github = {
    rest: {
        actions: {
            createWorkflowDispatch: ({ owner, repo, workflow_id, ref, inputs }) => {
                console.log("Mock Workflow Dispatch Triggered!");
                console.log(`Owner: ${owner}`);
                console.log(`Repo: ${repo}`);
                console.log(`Workflow ID: ${workflow_id}`);
                console.log(`Ref: ${ref}`);
                console.log("Inputs:", inputs);
                return Promise.resolve({
                    status: 201,
                    message: "Mock workflow dispatch successfully triggered.",
                });
            },
        },
    },
};

global.context = {
    repo: {
        owner: "mock-owner",
        repo: "mock-repo",
    },
};