#! /bin/bash

sudo apt update
sudo apt -y upgrade
rustup update
sudo snap refresh
sudo apt autoremove -y
