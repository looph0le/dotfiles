#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORMTHEME="qt5ct"
export RANGER_DEVICONS_SEPARATOR="  "

alias ls='ls --color=auto'
alias update='sudo pacman -Syyu'


PS1='\[\033[33m\][   \[\033[32m\]\u \[\033[35m\]\W \[\033[33m\]]\[\033[34m\] \$ \[\033[37m\]'

