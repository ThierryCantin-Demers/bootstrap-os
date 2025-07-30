#!/bin/bash

# Install rust
echo -e "${GREEN}Installing Rust from install script...${NOCOLOR}"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Source
. "$HOME/.cargo/env"

# Check that rust is install properly and fail if not
echo -e "${GREEN}Checking that Rust is installed properly...${NOCOLOR}"
rustc --version
if [ $? -ne 0 ]; then
    echo "Rust is not installed properly"
    exit 1
fi
