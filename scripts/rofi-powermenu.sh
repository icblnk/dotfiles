#!/bin/sh

# options to be displayed
option0="   Lock"
option1="   Reboot"
option2="⏻   Shutdown"
option3="   Logout"
option4="   Suspend"

uptime=$(uptime -p | sed -e 's/up / System Uptime \n  /g')

rofi_command="rofi -theme ~/.config/rofi/powermenu.rasi"

# options passed into variable
options="$option0\n$option1\n$option2\n$option3\n$option4"

chosen="$(echo -e "$options" | $rofi_command -p " $uptime " -lines 5 -dmenu -selected-row 2)"

case $chosen in
    $option0)
        ~/.scripts/lock_screen
        ;;
    $option1)
        loginctl reboot
        ;;
    $option2)
        loginctl poweroff
        ;;
    $option3)
        killall -u $USER
        ;;
    $option4)
        loginctl suspend
        ;;
esac
