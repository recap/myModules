#!/bin/bash

# Check if repository URL is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <submodule-repo-url> [submodule-name]"
  exit 1
fi

# Set variables
REPO_URL=$1
SUBMODULE_NAME=${2:-$(basename "$REPO_URL" .git)}

# Ensure beta-modules folder exists
mkdir -p beta-modules

# Add submodule
git submodule add "$REPO_URL" "beta-modules/$SUBMODULE_NAME"

# Initialize and update the submodule
# git submodule update --init --recursive

git commit -m "Add submodule $SUBMODULE_NAME"

echo "Submodule added at beta-modules/$SUBMODULE_NAME"

