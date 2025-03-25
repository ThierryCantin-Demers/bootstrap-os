#!/bin/bash

# Configure apt repository
echo -e "${GREEN}Configuring apt repository for spotify...${NOCOLOR}"
curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

# Install Spotify
echo -e "${GREEN}Installing Spotify...${NOCOLOR}"
sudo apt-get -y update && sudo apt-get install -y spotify-client

# Check that Spotify is installed properly and fail if not
echo -e "${GREEN}Checking that Spotify is installed properly...${NOCOLOR}"
spotify --version

if [ $? -ne 0 ]; then
    echo "Spotify is not installed properly"
    exit 1
fi
