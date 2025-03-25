#!/bin/bash

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get -y install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install Docker
echo -e "${GREEN}Installing Docker...${NOCOLOR}"
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Install Docker Desktop
echo -e "${GREEN}Installing Docker Desktop...${NOCOLOR}"
sudo apt -y install gnome-terminal
curl -fsSL https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb -o docker-desktop-amd64.deb
sudo apt-get update
sudo apt-get -y install ./docker-desktop-amd64.deb
rm docker-desktop-amd64.deb

# Verify installation
echo -e "${GREEN}Verifying Docker installation...${NOCOLOR}"
sudo docker run hello-world

if [ $? -ne 0 ]; then
    echo "Docker is not installed properly"
    exit 1
fi

# Add user to docker group
sudo groupadd docker
sudo usermod -aG docker $USER

# Run on boot
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
