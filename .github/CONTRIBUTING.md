## Contribution Guidelines

Thank you for considering contributing to this project! Please note:

- By submitting a contribution, you agree to our Contributor License Agreement (CLA).
- Contributions will not be merged unless you have signed the CLA.  
  [Read and sign the CLA here](https://cla-assistant.io/feskol/gitlab-arm64)

## Code of Conduct

Please note that this project is governed by a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in
this project, you agree to comply with its terms.

## How to contribute

### Code

1. Fork/clone the repository.
2. Create a new branch from `main`.
3. Implement your changes and add tests.
4. Ensure the tests pass successfully.
5. Ensure the GitHub Action "Test" pass successfully.
6. Create a pull request!

### Docs

1. Fork/clone the repository.
2. Add your changes.
3. Create a pull request.

## Sign the CLA

Before submitting a pull request, please sign the CLA using the following link:  
[Sign the CLA](https://cla-assistant.io/feskol/gitlab-arm64)

Contributions cannot be merged unless the CLA is signed.

Thank you for your contributions and for helping us build something great!

## Project structure:

```
...
├── .github
    └── generated-files         # files needed to run the autmatic "GitLab Release checker"
├── lib                         # bashunit binary
├── scripts                     # scripts for the build/syncversion workflows
└── tests
    ├── fixtures                # fixtures for the tests
    ├── helper                  # helping scripts (e.g. "test-case.sh"-files)
    └── unit                    # The actual tests
```