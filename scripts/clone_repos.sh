#!/bin/bash

# Create repos dir
echo -e "${GREEN}Creating repos directory...${NOCOLOR}"
mkdir -p "$TCD_CLONE_PATH"

# Clone repos
echo -e "${GREEN}Cloning repos...${NOCOLOR}"
for repo in $TCD_REPOS_TO_CLONE; do
  (cd $TCD_CLONE_PATH && git clone "https://github.com/${repo}.git")
done
