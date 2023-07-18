#!/usr/bin/sh

KB_FLAG="/tmp/___keyboard_layout.flag"

enable_se() {
    echo "ON" > "$KB_FLAG"
    setxkbmap -model pc105 -layout se,ua -option grp:alt_shift_toggle
}

disable_se() {
    echo "OFF" > "$KB_FLAG"
    setxkbmap -model pc105 -layout us,ua -option grp:alt_shift_toggle
}

if [[ -f "$KB_FLAG" ]];
then
    grep "ON" "$KB_FLAG" > /dev/null
    if [[ "$?" -ne 0 ]];
    then
        enable_se
    else
        disable_se
    fi
else
    enable_se
fi
