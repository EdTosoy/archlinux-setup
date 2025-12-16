# 🎨 My Arch Linux Setup

Personal Arch Linux configuration with HyprYou (Material You theme) on Hyprland.

## 🖥️ System Info

- **OS**: Arch Linux
- **WM**: Hyprland with HyprYou (Material You theme)
- **Terminal**: Alacritty / Kitty
- **Bar**: HyprYou bar (Material You styled)
- **Notifications**: Dunst
- **Launcher**: Wofi

## 📦 What's Included

```
config/
├── hypr/           # Hyprland config (fallback)
├── hypryou/        # HyprYou customizations
├── waybar/         # Waybar config (fallback)
├── wofi/           # App launcher styling
├── dunst/          # Notification daemon
└── kitty/          # Kitty terminal config
```

## 🚀 Installation

### Prerequisites

1. Fresh Arch Linux install with Hyprland
2. yay (AUR helper)

### Quick Install

```bash
git clone https://github.com/EdTosoy/archlinux-setup.git
cd archlinux-setup
./install.sh
```

### Manual Install

1. Install HyprYou:
```bash
yay -S hypryou hypryou-utils
```

2. Install dependencies:
```bash
sudo pacman -S alacritty dunst wofi grim slurp wl-clipboard
yay -S ttf-meslo-nerd-font-powerlevel10k tela-circle-icon-theme-nord satty
```

3. Copy configs:
```bash
cp -r config/* ~/.config/
cp .bashrc ~/.bashrc
```

4. Start HyprYou:
```bash
hyprland --config /usr/share/hypryou/configs/hyprland/main.conf
```

## ⌨️ Key Bindings

| Shortcut | Action |
|----------|--------|
| `SUPER + SPACE` | App Menu |
| `SUPER + RETURN` | Terminal |
| `SUPER + B` | Browser |
| `SUPER + E` | File Manager |
| `SUPER + D` | Settings |
| `SUPER + Q` | Close Window |
| `SUPER + W` | Sidebar |
| `SUPER + L` | Lock Screen |
| `SUPER + SHIFT + S` | Screenshot Region |

## 🎨 Customization

### Reduce Window Gaps
Edit `~/.config/hypryou/hyprland_generated.conf`:
```conf
general {
    gaps_in = 1
    gaps_out = 2
}
```

### Reduce Border Radius
Edit `~/.config/hypryou/hyprland_generated.conf`:
```conf
decoration {
    rounding = 6
}
```

## 📝 License

MIT - Feel free to use and modify!
