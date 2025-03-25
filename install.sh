#!/bin/bash

source ./colors.sh

# fail if any commands fails
set -e
trap 'echo -e "\n${RED}Command \"${BASH_COMMAND}\" failed with exit code $?${NOCOLOR}"' ERR

echo -e "${GREEN}Bootstrapping OS...${NOCOLOR}"

source ./.env
export $(cut -d= -f1 ./.env)

# Check that .env vars are set
if [ -z "${TCD_GIT_EMAIL}" ]; then
    echo -e "${RED}TCD_GIT_EMAIL is not set${NOCOLOR}"
    exit 1
fi

if [ -z "${TCD_GIT_NAME}" ]; then
    echo -e "${RED}TCD_GIT_NAME is not set${NOCOLOR}"
    exit 1
fi

if [ -z "${TCD_GITHUB_TOKEN}" ]; then
    echo -e "${RED}TCD_GITHUB_TOKEN is not set${NOCOLOR}"
    exit 1
fi

if [ -z "${TCD_SUDO_PASSWORD}" ]; then
    echo -e "${RED}TCD_SUDO_PASSWORD is not set${NOCOLOR}"
    exit 1
fi

# Provide sudo password from env var
echo $TCD_SUDO_PASSWORD | sudo -S echo "Sudo password provided"
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Update base packages
echo -e "${GREEN}Updating base packages...${NOCOLOR}"
sudo apt --yes --force-yes update
sudo apt --yes --force-yes upgrade

# Install base packages
echo -e "${GREEN}Installing base packages...${NOCOLOR}"
sudo apt --yes --force-yes install curl

# Install Brave and make default
./scripts/install_brave.sh

# Install rust
./scripts/install_rust.sh

# Install git
./scripts/setup_git.sh

echo -e "${GREEN}OS bootstrapped successfully!${NOCOLOR}"
