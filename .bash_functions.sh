set_keyboard() {
    xset r rate 200
    setxkbmap -model pc105 -layout us,ru -option grp:alt_shift_toggle
}

get_connected_monitors() {
    xrandr | grep " connected" | awk '{print $1;}'
}

get_laptop_monitor_name() {
    echo $(get_connected_monitors) | grep eDP
}

monitor_on() {
    laptop_monitor=$(get_laptop_monitor_name)
    xrandr | grep "2560x1440" > /dev/null
    if [[ $? -eq 0 ]]; then
        xrandr --output $laptop_monitor --off --output DP-1-6 --mode 2560x1440 --rate 165 --dpi 104/DP-1-6 --primary
    else
        xrandr --output DP-1-4 --auto --primary --right-of $laptop_monitor --output DP-3 --auto --right-of DP-1-4 --output $laptop_monitor --auto
    fi
}

monitor_off() {
    laptop_monitor=$(get_laptop_monitor_name)
    xrandr --output DP-1-4 --off --output HDMI-1-2 --off --output DP-1-6 --off --output DP-3 --off --output $laptop_monitor --auto --primary --dpi 95
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

function sim_cpu_load() {
    for i in $(seq 32 $END) ; do while : ; do : ; done & done
    read -n 1 -s -r -p "Press any key to finish"
    kill $(jobs -p)
}

function kp() {
    local pids=$(ps -ef | sed 1d | eval "fzf -m --header='[kill:process]'" | awk '{print $2}')
    for pid in $pids
    do
        kill $pid
    done
}

function cd() {
  if [[ $# -eq 0 ]]
  then
  pushd ${HOME} > /dev/null
  else
  pushd "$1" > /dev/null
  fi
}

function bd() {
  if [[ $# -eq 0 ]]
  then
    popd > /dev/null
  else
    for i in $(seq ${1})
    do
      popd > /dev/null
    done
  fi
}