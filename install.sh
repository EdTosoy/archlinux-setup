#!/bin/bash

# Arch Linux + HyprYou Setup Script
# Author: EdTosoy

set -e

# Get the script's directory for reliable relative paths
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

echo "🚀 Starting Arch Linux + HyprYou Setup..."

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper function to backup files/directories
backup_item() {
    local target="$1"
    if [ -e "$target" ]; then
        local backup="${target}.bak_$(date +%Y%m%d_%H%M%S)"
        echo -e "${YELLOW}Backing up $target to $backup...${NC}"
        cp -r "$target" "$backup"
    fi
}

# Check if running on Arch
if ! command -v pacman &> /dev/null; then
    echo -e "${RED}This script is designed for Arch Linux only!${NC}"
    exit 1
fi

# Check for yay
if ! command -v yay &> /dev/null; then
    echo -e "${YELLOW}Installing yay...${NC}"
    sudo pacman -S --needed --noconfirm git base-devel
    
    # Clean up previous attempts if any
    rm -rf /tmp/yay
    
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd - > /dev/null
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
    libnotify \
    timeshift \
    zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    starship \
    yazi \
    ffmpegthumbnailer \
    p7zip \
    jq \
    poppler \
    fd \
    ripgrep \
    fzf \
    zoxide \
    imagemagick

echo -e "${GREEN}Installing AUR packages...${NC}"
yay -S --noconfirm \
    ttf-meslo-nerd-font-powerlevel10k \
    tela-circle-icon-theme-nord \
    satty \
    bibata-cursor-theme \
    hyprlock \
    hypridle \
    ly

echo -e "${GREEN}Copying configuration files...${NC}"

# Ensure config directory exists in the repo
if [ -d "$SCRIPT_DIR/config" ]; then
    # Backup potentially existing configs that we are about to overwrite
    # Note: cp -r config/* will overwrite directories inside ~/.config/.
    # A simple backup of ~/.config is too much. Ideally we backup specific folders.
    # For now, let's backup specific known conflict targets if we can identify them easier,
    # or just backup the specific folders found in config/
    
    for dir in "$SCRIPT_DIR/config/"*; do
        basename_dir=$(basename "$dir")
        target_dir="$HOME/.config/$basename_dir"
        backup_item "$target_dir"
    done
    
    cp -r "$SCRIPT_DIR/config/"* ~/.config/
else
    echo -e "${RED}Error: config directory not found at $SCRIPT_DIR/config${NC}"
    exit 1
fi

# Backup and copy bash/zsh files
backup_item "$HOME/.bashrc"
cp "$SCRIPT_DIR/.bashrc" "$HOME/.bashrc" 2>/dev/null || true

backup_item "$HOME/.zshrc"
[ -f "$SCRIPT_DIR/.zshrc" ] && cp "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"

backup_item "$HOME/.bash_profile"
cp "$SCRIPT_DIR/.bash_profile" "$HOME/.bash_profile" 2>/dev/null || true

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
