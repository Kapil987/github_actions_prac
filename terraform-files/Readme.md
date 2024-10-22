## Prerequisite
1) s3 bucket name to be specified in provider.tf
2) Update Github Account Token in github secrets which suitable permission to create an runner auth token
3) Update Aws credentials in github secrets
4) Update Runner name and repo name in github-workflow.yml in env or you may input these in workflow dispatcher GUI


## Troubleshooting

This section contains common issues encountered and their solutions. Use this guide to resolve errors you might face during setup.

### 1. Error: "Invalid value for 'vars' parameter: vars map does not contain key"

- **Cause**: The script references a variable (`TEST_VAR`) that is not passed by `templatefile` Even though it is defined in the init.sh script.
- **Fix**: Either pass the variable from Terraform or remove its reference from the script.

### 2. Error: "node: No such file or directory"
- **Cause**: Node.js is not installed or available on the runner.
- **Fix**: Ensure Node.js is installed in the workflow.
- **Example**:
```
- name: Setup Node.js
  uses: actions/setup-node@v2
  with:
    node-version: '14'
```

### 3. Error: "Http response code: NotFound"
- **Cause**: the repository URL or token may be incorrect.
- **Fix**: Verify the repository URL and the GitHub token.
