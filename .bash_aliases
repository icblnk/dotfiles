# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Neovim
alias vim=nvim

# emacs client
alias e='emacsclient --no-wait'
alias en='emacs -nw'

alias cat='bat -p --paging never'

# ===== Make ssh-agent to run system-wide ======================================
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
# ==============================================================================

######### Functions ############################################################
genpasswdhash() {
    read -sp 'Password: ' passwd
    echo
    echo -n "Hash: "
    python3 -c 'import crypt; print(crypt.crypt("$passwd", crypt.mksalt(crypt.METHOD_SHA512)))'
}

set_keyboard() {
    xset r rate 200
    setxkbmap -model pc105 -layout us,ru -option grp:alt_shift_toggle
}

monitor_on() {
    xrandr | grep "DP-3 connected" > /dev/null
    if [[ $? -eq 0 ]]; then
	xrandr --output eDP-1 --off --output DP-3 --mode 2560x1440 --rate 144 --primary
    else
	xrandr --output DP-1 --auto --primary --right-of eDP-1 --output HDMI-2 --auto --right-of DP-1
    fi
}

monitor_off() {
    xrandr --output DP-1 --off --output HDMI-2 --off --output DP-3 --off --output eDP-1 --auto --primary
}

__prompt_command() {
    local exit_code="$?"
    local hasjobs=$(jobs -p)
    local exit_code_text=""
    if [[ $exit_code -ne 0 ]]; then
	exit_code_text="[\[\e[91m\]$exit_code\[\e[39m\]] "
    fi
    PS1="${exit_code_text}\[\e[32m\]\u\[\e[39m\]\[\e[94m\]@\[\e[39m\]\[\e[36m\]\h\[\e[39m\]${hasjobs:+(\[\e[93m\]\j\[\e[39m\])}:\w\$ "
}
