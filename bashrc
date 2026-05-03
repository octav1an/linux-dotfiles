export XDG_CONFIG_HOME="$HOME/.config"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

PAGER=less
DOTFILES_DIR=$HOME/.dotfiles

shopt -s histappend # append to the history file, don't overwrite it
HISTCONTROL=ignoreboth
HISTSIZE=20000
HISTFILESIZE=20000

# Number of Ctrl+D presses required to exit
IGNOREEOF=99

# check the window size after each command and, if necessary
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Set up fzf key bindings and fuzzy completion
source /usr/share/doc/fzf/examples/key-bindings.bash

# Set a bold green user@host, a blue directory, and a reset color for the command
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Set the window title (the tab name in your terminal app)
case "$TERM" in
    xterm*|rxvt*) PS1="\[\e]0;\u@\h: \w\a\]$PS1" ;;
esac

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f "$DOTFILES_DIR/conf-common/aliases" ]; then
    source "$DOTFILES_DIR/conf-common/aliases"
fi

# Wrapper with pager
firewall-cmd() {
    command firewall-cmd "$@" | $PAGER -F
}
