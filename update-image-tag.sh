#!/bin/bash

set -e

SHA=$1
DOCKERHUB_USERNAME=$DOCKERHUB_USERNAME
DOCKER_REPO_NAME=$DOCKER_REPO_NAME
GIT_TOKEN=$GIT_TOKEN

# Configure git
git config --global user.name "github-actions[bot]"
git config --global user.email "github-actions[bot]@users.noreply.github.com"

# Update the CronJob manifest
sed -i "s#image: docker.io/${DOCKERHUB_USERNAME}/${DOCKER_REPO_NAME}:[0-9a-zA-Z]*#image: docker.io/${DOCKERHUB_USERNAME}/${DOCKER_REPO_NAME}:${SHA}#" kubernetes/metric-cron.yaml

# Commit and push the changes
git add kubernetes/metric-cron.yaml
git commit -m "Update image version to ${SHA}"
git push https://${GIT_TOKEN}@github.com/RohanRusta21/one2n-assignment.git main
