#!/bin/bash

# Download installer (url: https://discord.com/api/download?platform=linux)
echo -e "${GREEN}Downloading Discord installer...${NOCOLOR}"
curl -o discord.deb -L https://discord.com/api/download?platform=linux

# Install Discord
echo -e "${GREEN}Installing Discord...${NOCOLOR}"
sudo apt -y install ./discord.deb

# Clean up
rm discord.deb

# Check that Discord is installed properly and fail if not
echo -e "${GREEN}Checking that Discord is installed properly...${NOCOLOR}"
which discord

if [ $? -ne 0 ]; then
    echo "Discord is not installed properly"
    exit 1
fi
