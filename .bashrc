#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export QT_QPA_PLATFORMTHEME="qt5ct"
alias ls='ls --color=auto'
PS1='\[\033[33m\][   \[\033[32m\]\u \[\033[35m\]\W \[\033[33m\]]\[\033[34m\] \$ \[\033[37m\]'
