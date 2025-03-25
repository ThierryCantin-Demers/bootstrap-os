#!/bin/bash

# Install git
echo -e "${GREEN}Installing Git...${NOCOLOR}"
sudo apt --yes --force-yes install git-all

# Check that git is install properly and fail if not
git --version
if [ $? -ne 0 ]; then
    echo "Git is not installed properly"
    exit 1
fi

# Install gh cli
echo -e "${GREEN}Installing GitHub CLI...${NOCOLOR}"
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
        && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

# Check that gh is install properly and fail if not
gh --version
if [ $? -ne 0 ]; then
    echo "github cli is not installed properly"
    exit 1
fi

# Setup git
echo -e "${GREEN}Setting up Git...${NOCOLOR}"
git config --global user.email "${TCD_GIT_EMAIL}"
git config --global user.name "${TCD_GIT_NAME}"

# Connected to github
echo -e "${GREEN}Connecting to GitHub...${NOCOLOR}"
echo $TCD_GITHUB_TOKEN | gh auth login --with-token

# Check that gh is connected to github properly and fail if not
gh auth status

if [ $? -ne 0 ]; then
    echo "github cli is not connected to github properly"
    exit 1
fi
