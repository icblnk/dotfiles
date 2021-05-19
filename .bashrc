# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000

export TERM=tmux-256color
export EDITOR=nvim

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

[ -f ~/.bash_functions.sh ] && source ~/.bash_functions.sh

[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PROMPT_COMMAND=__prompt_command

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Execute machine-specific commands
[ -f ~/.host_specific.sh ] && source ~/.host_specific.sh

# Add directory to include to $PATH
[ -d ~/.custom_bin ] && PATH=~/.custom_bin:$PATH

# Add directory to include to $PATH
[ -d ~/.local/bin ] && PATH=~/.local/bin:$PATH

# fzf
export FZF_TMUX="TRUE"
[ -f /usr/share/fzf/key-bindings.bash ] \
    && source /usr/share/fzf/key-bindings.bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# tmux git status bar
[ -n "$TMUX" ] && [ -f ~/.tmux-git.sh ] && source ~/.tmux-git.sh

# Make ssh-agent to run system-wide
SSH_ENV="$HOME/.ssh/env"

function start_agent {
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
}

if [[ -f "$SSH_ENV" ]]; then
    . "$SSH_ENV" > /dev/null
    if [[ ! -z "$SSH_AGENT_PID" ]]; then
        ps -ef | grep "$SSH_AGENT_PID" | grep "ssh-agent$" > /dev/null || {
            start_agent;
        }
    fi
else
    start_agent;
fi
