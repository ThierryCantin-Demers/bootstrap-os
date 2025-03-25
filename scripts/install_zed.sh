#!/bin/bash

# Install Zed
echo -e "${GREEN}Installing Zed from install script...${NOCOLOR}"
curl -f https://zed.dev/install.sh | sh

# Add Zed to PATH
echo -e "${GREEN}Adding Zed to PATH...${NOCOLOR}"
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc

# Check that Zed is installed properly and fail if not
echo -e "${GREEN}Checking that Zed is installed properly...${NOCOLOR}"
which zed

if [ $? -ne 0 ]; then
    echo "Zed is not installed properly"
    exit 1
fi
