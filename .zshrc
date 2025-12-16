# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Basic Zsh Settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

# Completion
autoload -Uz compinit
compinit

# Plugins (Arch Linux Paths)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null || echo "zsh-autosuggestions not found"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null || echo "zsh-syntax-highlighting not found"

# Starship Prompt
eval "$(starship init zsh)"

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -la'
alias ..='cd ..'
alias ...='cd ../..'

# Hyprland specific
alias hypryou="hyprland --config /usr/share/hypryou/configs/hyprland/main.conf"
