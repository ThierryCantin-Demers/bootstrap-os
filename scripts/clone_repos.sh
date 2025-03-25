#!/bin/bash

# Create repos dir
echo -e "${GREEN}Creating repos directory...${NOCOLOR}"
mkdir -p "$TCD_CLONE_PATH"

# Clone repos
echo -e "${GREEN}Cloning repos...${NOCOLOR}"
for repo in $TCD_REPOS_TO_CLONE; do
  repo_name=$(basename "$repo")
  repo_dir="$TCD_CLONE_PATH/$repo_name"

  # Check if the repository directory already exists
  if [ ! -d "$repo_dir" ]; then
    echo -e "${GREEN}Cloning $repo...${NOCOLOR}"
    (cd "$TCD_CLONE_PATH" && gh repo clone "$repo" -- --recurse-submodules)
  else
    echo -e "${GREEN}$repo already exists. Skipping clone.${NOCOLOR}"
  fi
done
