// mock-github.js
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