#!/bin/bash

# Define colors for pretty output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Update and upgrade the system
echo -e "${GREEN}Updating and upgrading the system...${NC}"
sudo apt update && sudo apt upgrade -y

# Install dependencies
echo -e "${GREEN}Installing essential dependencies...${NC}"
sudo apt install -y curl wget git software-properties-common apt-transport-https gnupg lsb-release

# Install Visual Studio Code
echo -e "${GREEN}Installing Visual Studio Code...${NC}"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code
rm -f packages.microsoft.gpg

# Install KiCad Nightly
echo -e "${GREEN}Installing KiCad Nightly...${NC}"
sudo add-apt-repository -y ppa:kicad/kicad-dev-nightly
sudo apt update
sudo apt install -y kicad-nightly

# Install Arduino IDE
echo -e "${GREEN}Installing Arduino IDE...${NC}"
wget -qO arduino.tar.xz https://downloads.arduino.cc/arduino-ide/latest-linux64.tar.xz
tar -xf arduino.tar.xz
sudo mv arduino-ide_* /opt/arduino-ide
sudo ln -s /opt/arduino-ide/arduino-ide /usr/local/bin/arduino-ide
rm arduino.tar.xz

# Install Brave Browser
echo -e "${GREEN}Installing Brave Browser...${NC}"
sudo apt install -y apt-transport-https curl
curl -fsSL https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo gpg --dearmor -o /usr/share/keyrings/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser

# Install Orca Slicer
echo -e "${GREEN}Installing Orca Slicer...${NC}"
wget -qO orca-slicer.deb https://github.com/SoftFever/OrcaSlicer/releases/latest/download/OrcaSlicer-Linux.deb
sudo dpkg -i orca-slicer.deb
sudo apt-get -f install -y
rm orca-slicer.deb

# Final cleanup
echo -e "${GREEN}Cleaning up...${NC}"
sudo apt autoremove -y
sudo apt clean

# Done
echo -e "${GREEN}All software installed successfully!${NC}"
