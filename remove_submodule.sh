#!/bin/bash

# Check if submodule path is provided
# if [ -z "$1" ]; then
#   echo "Usage: $0 <submodule-path>"
#   exit 1
# fi

# SUBMODULE_PATH="$1"

# Deinitialize submodule
# git submodule deinit -f "$SUBMODULE_PATH"

# Remove submodule from tracking
# git rm -r --cached "$SUBMODULE_PATH"

# Remove submodule entry from .gitmodules
# git config --remove-section "submodule $SUBMODULE_PATH" 2>/dev/null
# sed  "/submodule \"$SUBMODULE_PATH\"/,+2d" .gitmodules

# Commit changes
# git add .gitmodules
# git commit -m "Removed submodule $SUBMODULE_PATH"

# Delete submodule files
# rm -rf "$SUBMODULE_PATH"
# rm -rf ".git/modules/$SUBMODULE_PATH"

# echo "Submodule $SUBMODULE_PATH removed successfully."

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

# Remove the submodule directory
rm -rf "$SUBMODULE_PATH"

# Remove submodule from Git
git rm -f "$SUBMODULE_PATH"

# Escape special characters in SUBMODULE_PATH for use in config commands
ESCAPED_PATH=$(printf '%s\n' "$SUBMODULE_PATH" | sed 's/[\/&]/\\&/g')

# Remove submodule data from .gitmodules and .git/config
git config --file .gitmodules --remove-section "submodule.$SUBMODULE_PATH" 2>/dev/null
git config --remove-section "submodule.$SUBMODULE_PATH" 2>/dev/null

# Remove the corresponding section from .gitmodules
sed  "/\[submodule \"$ESCAPED_PATH\"\]/,/^\s*$/d" .gitmodules

# Commit the changes
git commit -am "Removed submodule $SUBMODULE_NAME"

echo "Submodule '$SUBMODULE_NAME' removed successfully, including from .gitmodules."

