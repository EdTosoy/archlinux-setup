#!/bin/bash

# Arch Linux + HyprYou Setup Script
# Author: EdTosoy

set -e

echo "🚀 Starting Arch Linux + HyprYou Setup..."

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running on Arch
if ! command -v pacman &> /dev/null; then
    echo -e "${RED}This script is designed for Arch Linux only!${NC}"
    exit 1
fi

# Check for yay
if ! command -v yay &> /dev/null; then
    echo -e "${YELLOW}Installing yay...${NC}"
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd -
fi

echo -e "${GREEN}Installing HyprYou...${NC}"
yay -S --noconfirm hypryou hypryou-utils

echo -e "${GREEN}Installing dependencies...${NC}"
sudo pacman -S --noconfirm \
    alacritty \
    dunst \
    wofi \
    grim \
    slurp \
    wl-clipboard \
    noto-fonts \
    noto-fonts-emoji \
    noto-fonts-cjk \
    otf-font-awesome \
    libnotify

echo -e "${GREEN}Installing AUR packages...${NC}"
yay -S --noconfirm \
    ttf-meslo-nerd-font-powerlevel10k \
    tela-circle-icon-theme-nord \
    satty \
    bibata-cursor-theme

echo -e "${GREEN}Copying configuration files...${NC}"
cp -r config/* ~/.config/
cp .bashrc ~/.bashrc 2>/dev/null || true
cp .bash_profile ~/.bash_profile 2>/dev/null || true

echo -e "${GREEN}Updating font cache...${NC}"
fc-cache -fv

echo ""
echo -e "${GREEN}✅ Installation complete!${NC}"
echo ""
echo "To start HyprYou, run:"
echo -e "${YELLOW}  hyprland --config /usr/share/hypryou/configs/hyprland/main.conf${NC}"
echo ""
echo "Or add 'hypryou' alias to your .bashrc (already added)"
echo ""
