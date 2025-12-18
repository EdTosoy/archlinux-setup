# 🎨 My Arch Linux Setup

Personal Arch Linux configuration with Illogical Impulse (end-4 dots) on Hyprland.

## 🖥️ System Info

- **OS**: Arch Linux
- **WM**: Hyprland with Illogical Impulse
- **Terminal**: Foot / Kitty
- **Shell**: Zsh with Starship prompt
- **Bar**: Quickshell (illogical-impulse)
- **Notifications**: Dunst
- **Launcher**: Wofi

## 📦 What's Included

```
config/
├── hypr/              # Hyprland configuration
│   ├── hyprland/      # Core configs (keybinds, general, execs, etc.)
│   ├── custom/        # Custom overrides
│   ├── hyprlock/      # Lock screen configs
│   ├── hypridle.conf  # Idle management
│   ├── hyprlock.conf  # Lock screen settings
│   └── hyprpaper.conf # Wallpaper config
├── waybar/            # Waybar config (fallback)
├── wofi/              # App launcher styling
├── dunst/             # Notification daemon
├── kitty/             # Kitty terminal config
├── ly/                # Ly display manager config
└── starship.toml      # Starship prompt config
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

1. Install Illogical Impulse (end-4 dots):

```bash
bash <(curl -s "https://end-4.github.io/dots-hyprland-wiki/setup.sh")
```

2. Install dependencies:

```bash
sudo pacman -S dunst wofi grim slurp wl-clipboard zsh starship yazi
yay -S ttf-meslo-nerd-font-powerlevel10k tela-circle-icon-theme-nord satty hyprlock hypridle ly
```

3. Copy configs:

```bash
cp -r config/* ~/.config/
cp .bashrc ~/.bashrc
cp .zshrc ~/.zshrc
```

## ⌨️ Key Bindings

| Shortcut | Action |
|----------|--------|
| `SUPER + SPACE` | App Menu |
| `SUPER + RETURN` | Terminal |
| `SUPER + B` | Browser |
| `SUPER + E` | File Manager |
| `SUPER + Q` | Close Window |
| `SUPER + W` | Overview/Sidebar |
| `SUPER + L` | Lock Screen |
| `SUPER + SHIFT + S` | Screenshot Region |

## 🎨 Customization

### Modify Window Gaps

Edit `~/.config/hypr/custom/general.conf`:

```conf
general {
    gaps_in = 1
    gaps_out = 2
}
```

### Custom Keybinds

Edit `~/.config/hypr/custom/keybinds.conf` to add your own keybindings.

## 📝 License

MIT - Feel free to use and modify!
