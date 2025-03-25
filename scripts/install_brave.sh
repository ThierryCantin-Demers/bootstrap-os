#!/bin/bash

echo -e "${GREEN}Installing Brave from install script...${NOCOLOR}"
curl -fsS https://dl.brave.com/install.sh | sh

echo -e "${GREEN}Setting Brave as default browser...${NOCOLOR}"
sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/bin/brave-browser 500
sudo update-alternatives --set x-www-browser /usr/bin/brave-browser

echo -e "${YELLOW} Brave: Need to manually join sync chain as it cannot be done in CLI ${NOCOLOR}"
