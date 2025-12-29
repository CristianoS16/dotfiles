#!/bin/bash

# --- 1. SYSTEM UPDATE & ESSENTIALS ---
echo "Updating system and installing base development tools..."
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm flatpak git curl wget base-devel

# --- 2. NATIVE APPLICATIONS (PACMAN) ---
# Installing official repository packages
echo "Installing native applications..."
# General utilities
sudo pacman -S --noconfirm htop kitty kolourpaint solaar vlc libreoffice-still obs-studio steam

# For kitty, define it as default terminal emulator in System Settings and remove shotcut from konsole
# For Steam, enable "Steam Play for all other titles" in Compatibility settings

# --- 3. SHELL & TERMINAL SETUP (ZSH) ---
echo "Configuring ZSH and terminal environment..."
sudo pacman -S --noconfirm zsh

# Change default shell to ZSH
chsh -s $(which zsh)

# Install Oh My Zsh (unattended mode to avoid breaking the script)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install ZSH Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install p10k: https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#meslo-nerd-font-patched-for-powerlevel10k

# plugins=(
#         git
#         sudo
#         extract
#         web-search
#         zsh-autosuggestions
#         zsh-syntax-highlighting
# )

# Aliases
# alias disable-bb="sudo systemctl stop warsaw.service && sudo systemctl disable warsaw.service"
# alias enable-bb="sudo execstack -s /usr/local/bin/warsaw/core && sudo systemctl start warsaw.service && sudo systemctl restart warsaw.service"
# alias pos="cd /home/cristiano/Documents/pos/code"

# To enable BB security module, run:
# sudo systemctl stop warsaw.service
# sudo systemctl disable warsaw.service

# To disable BB security module, run:
# sudo execstack -s /usr/local/bin/warsaw/core
# sudo systemctl start warsaw.service
# sudo systemctl restart warsaw.service

# --- 4. DOCKER CONFIGURATION ---
echo "Setting up Docker..."
sudo pacman -S --noconfirm docker docker-compose
sudo systemctl enable --now docker.service

# Use Docker without sudo
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
# Note: A logout/restart is required for group changes to take effect
echo "Docker installed. Run 'docker run hello-world' after your next login."

# --- 5. AUR PACKAGES (VIA YAY) ---
echo "Installing AUR packages..."
# Development, Browsers, and Security
yay -S --noconfirm visual-studio-code-bin google-chrome spotify \
    anki-bin insomnia-bin freedownloadmanager warsaw-bin

# --- 6. FLATPAK APPLICATIONS ---
echo "Installing Flatpak applications..."
flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub com.discordapp.Discord -y

echo "Setup complete! Please restart your machine to apply all changes."

# Additional manual steps:
#  - Add Github SSH key
#  - Configure kitty as default terminal emulator
#  - Configure Oh My Zsh and p10k theme
#  - Config Keyboard Layouts in System Settings:
#     - Model: "Generic | Brazilian ABNT2"
#     - Layout: "English (US, intl., with dead keys)"
#  - Add Dolphin extension to open files/repositories in VSCode