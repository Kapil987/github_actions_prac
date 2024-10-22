#!/bin/bash

#set -e

sudo apt-get update
echo "Updating system... Done."

echo "Setting up variables... Done."

# Create a folder
mkdir -p ${WORK_DIR} && chown -R ubuntu:ubuntu ${WORK_DIR} && cd ${WORK_DIR} || true
echo "Created and navigated to actions-runner directory."

# Download the latest runner package
curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"

echo "Downloaded GitHub Actions Runner package."

# Extract the installer
tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
echo "Extracted GitHub Actions Runner package."

# Change permission of extracted folder
chown -R ubuntu:ubuntu ${WORK_DIR}

# Switch to ubuntu user and configure the runner
su - ubuntu -c "cd ${WORK_DIR} && ./config.sh --url ${REPO_URL} --token ${GITHUB_TOKEN} --name '${RUNNER_NAME}' --runnergroup 'Default' --labels 'self-hosted,linux' --unattended --replace"

echo "Configured GitHub Actions Runner."

# Switch to ubuntu user and run the runner in the background
su - ubuntu -c "cd ${WORK_DIR} && nohup ./run.sh &"
echo "Started GitHub Actions Runner in the background."
