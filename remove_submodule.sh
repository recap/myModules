#!/bin/bash

# Check if submodule name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <submodule-name>"
  exit 1
fi

# Set variables
SUBMODULE_NAME=$1
SUBMODULE_PATH="beta-modules/$SUBMODULE_NAME"

# Check if the submodule exists
if [ ! -d "$SUBMODULE_PATH" ]; then
  echo "Error: Submodule '$SUBMODULE_NAME' not found in beta-modules."
  exit 1
fi

# Deinitialize the submodule
git submodule deinit -f "$SUBMODULE_PATH"

git rm --cached "$SUBMODULE_PATH"

# Remove the submodule directory
rm -rf "$SUBMODULE_PATH" 2> /dev/null

# Remove submodule from Git
git rm -f "$SUBMODULE_PATH"

# Escape special characters in SUBMODULE_PATH for use in config commands
ESCAPED_PATH=$(printf '%s\n' "$SUBMODULE_PATH" | sed 's/[\/&]/\\&/g')

# Remove submodule data from .gitmodules and .git/config
git config --file .gitmodules --remove-section "submodule.$SUBMODULE_PATH" 2>/dev/null
git config --remove-section "submodule.$SUBMODULE_PATH" 2>/dev/null

# Remove the corresponding section from .gitmodules
sed  -i "/\[submodule \"$ESCAPED_PATH\"\]/,/^\s*$/d" .gitmodules 2> /dev/null


# Remove the submodule directory
rm -rf ".git/modules/$SUBMODULE_PATH"

# Remove submodule from Git
git rm -f ".git/modules/$SUBMODULE_PATH"

# Commit the changes
git commit -am "Removed submodule $SUBMODULE_NAME"

echo "Submodule '$SUBMODULE_NAME' removed successfully, including from .gitmodules."

