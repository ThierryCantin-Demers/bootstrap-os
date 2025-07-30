#!/bin/bash

source ./colors.sh

# fail if any commands fails
set -e
trap 'echo -e "\n${RED}Command \"${BASH_COMMAND}\" failed with exit code $?${NOCOLOR}"' ERR

echo -e "${GREEN}Bootstrapping OS...${NOCOLOR}"

# Load .env vars
source ./.env
export $(cut -d= -f1 ./.env)

# Load utils
. ./utils.sh

# Check that .env vars are set
check_env_var TCD_GIT_EMAIL
check_env_var TCD_GIT_NAME
check_env_var TCD_GITHUB_TOKEN
check_env_var TCD_SUDO_PASSWORD
check_env_var TCD_CLONE_PATH
check_env_var TCD_REPOS_TO_CLONE

# Provide sudo password from env var
echo $TCD_SUDO_PASSWORD | sudo -S echo "Sudo password provided"
while true; do echo $TCD_SUDO_PASSWORD | sudo -S echo "Sudo password provided"; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Update base packages
echo -e "${GREEN}Updating base packages...${NOCOLOR}"
sudo apt --yes --force-yes update
sudo apt --yes --force-yes upgrade

# Install base packages
echo -e "${GREEN}Installing base packages...${NOCOLOR}"
sudo apt --yes --force-yes install curl

# Install Brave and make default browser
./scripts/install_brave.sh

# Install rust
./scripts/install_rust.sh

# Install git
./scripts/setup_git.sh

# Clone desired repos
./scripts/clone_repos.sh

# Install Zed
./scripts/install_zed.sh

# Install Spotify
./scripts/install_spotify.sh

# Install Docker
./scripts/install_docker.sh

# Install Discord
./scripts/install_discord.sh

# Install Lazygit
./scripts/install_lazygit.sh

echo -e "${GREEN}OS bootstrapped successfully!${NOCOLOR}"
