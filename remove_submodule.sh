#!/bin/bash

# Check if submodule path is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <submodule-path>"
  exit 1
fi

SUBMODULE_PATH="$1"

# Deinitialize submodule
git submodule deinit -f "$SUBMODULE_PATH"

# Remove submodule from tracking
git rm -r --cached "$SUBMODULE_PATH"

# Remove submodule entry from .gitmodules
git config --remove-section "submodule.$SUBMODULE_PATH" 2>/dev/null
sed -i "/submodule \"$SUBMODULE_PATH\"/,+2d" .gitmodules

# Commit changes
git add .gitmodules
git commit -m "Removed submodule $SUBMODULE_PATH"

# Delete submodule files
rm -rf "$SUBMODULE_PATH"
rm -rf ".git/modules/$SUBMODULE_PATH"

echo "Submodule $SUBMODULE_PATH removed successfully."


