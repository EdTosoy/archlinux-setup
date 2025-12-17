#!/bin/bash

# Arch Linux + Illogical Impulse Hyprland Setup Script
# Author: EdTosoy

set -e

# Get the script's directory for reliable relative paths
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

echo "🚀 Starting Arch Linux + Illogical Impulse Hyprland Setup..."

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

echo -e "${GREEN}Installing Illogical Impulse (end-4 dots)...${NC}"
# Install the illogical-impulse dotfiles
bash <(curl -s "https://end-4.github.io/dots-hyprland-wiki/setup.sh")

echo -e "${GREEN}Installing additional dependencies...${NC}"
sudo pacman -S --noconfirm \
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
    ly \
    go \
    python \
    python-pip \
    python-pipx \
    postgresql \
    npm

echo -e "${GREEN}Copying configuration files...${NC}"

# Ensure config directory exists in the repo
if [ -d "$SCRIPT_DIR/config" ]; then
    for dir in "$SCRIPT_DIR/config/"*; do
        basename_dir=$(basename "$dir")
        
        # Special handling for ly (system config)
        if [ "$basename_dir" == "ly" ]; then
             echo -e "${YELLOW}Configuring ly (requires sudo)...${NC}"
             sudo mkdir -p /etc/ly
             if [ -f "$dir/config.ini" ]; then
                 sudo cp "$dir/config.ini" /etc/ly/config.ini
             fi
             # Enable ly service
             echo -e "${GREEN}Enabling ly service...${NC}"
             sudo systemctl enable ly@tty2.service
             continue
        fi

        target_dir="$HOME/.config/$basename_dir"
        backup_item "$target_dir"
    done
    
    # Copy all configs except ly (which is handled above)
    for dir in "$SCRIPT_DIR/config/"*; do
        basename_dir=$(basename "$dir")
        [ "$basename_dir" == "ly" ] && continue
        cp -r "$dir" ~/.config/
    done

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
echo "Your system is now configured with Illogical Impulse Hyprland dotfiles."
echo "Please reboot or log out and log back in to apply all changes."
echo ""
