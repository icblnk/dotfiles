#!/bin/sh

source ~/.bash_functions.sh

killall polybar 2> /dev/null

primary_monitor=$(get_primary_monitor)

for monitor in $(get_active_monitors);
do
    if [ "$monitor" = "$primary_monitor" ];
    then
        MONITOR=$monitor polybar main &
    else
        MONITOR=$monitor polybar aux &
    fi
done
