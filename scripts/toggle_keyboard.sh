#!/usr/bin/sh

enable_se() {
    swaymsg 'input "type:keyboard" xkb_layout "se,ua"'
}

disable_se() {
    swaymsg 'input "type:keyboard" xkb_layout "us,ua"'
}

if [[ $(swaymsg -t get_inputs | jq -r '[.[] | select(.type == "keyboard")][0] | .xkb_layout_names[0]') =~ "English" ]];
then
    enable_se
else
    disable_se
fi
