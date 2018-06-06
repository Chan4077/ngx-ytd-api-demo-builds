#!/bin/bash

# Automatically exit if any command exits with a non-zero code
set -e

commitSha=$(git rev-parse --short HEAD)
commitMessage=$(git log --oneline -n 1)
echo -e "\x1b[34mDeploying commit ${commitSha} to Firebase...\x1b[0m"
if [[ -n "$FIREBASE_TOKEN" ]]; then
	firebase deploy --only hosting --message "${commitMessage}" --token "${FIREBASE_TOKEN}"
else
	echo -e "\x1b[31m\x1b[1mERROR: Please set the FIREBASE_TOKEN environment variable." >&2
	exit 1
fi