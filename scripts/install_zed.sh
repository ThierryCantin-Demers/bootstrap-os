#!/bin/bash

# Install Zed
echo -e "${GREEN}Installing Zed from install script...${NOCOLOR}"
curl -f https://zed.dev/install.sh | sh

# Add Zed to PATH
echo -e "${GREEN}Adding Zed to PATH...${NOCOLOR}"
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
