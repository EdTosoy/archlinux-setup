#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# HyprYou alias - start HyprYou with "hypryou" command
alias hypryou="hyprland --config /usr/share/hypryou/configs/hyprland/main.conf"
