#!/usr/bin/env bash

# You can call this script like this:
# $ ./brightnessControl.sh up
# $ ./brightnessControl.sh down

# Script inspired by these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

function get_brightness {
  brightnessctl -m -d amdgpu_bl0 | awk -F, '{print substr($4, 0, length($4)-1)}'
}

function send_notification {
  icon="~/icons/sun.svg"
  brightness=$(get_brightness)
  # Make the bar with the special character ─ (it's not dash -)
  # https://en.wikipedia.org/wiki/Box-drawing_character
  bar=$(seq -s "🮆" 0 $((brightness / 7)) | sed 's/[0-9]//g')
  # Send the notification
  dunstify --appname="‎		 Brightness" -i "$icon" -r 5555 -u normal "$bar"
}

case $1 in
  up)
    # increase the backlight by 5%
    brightnessctl -d amdgpu_bl0 s +7%
    send_notification
    ;;
  down)
    # decrease the backlight by 5%
    brightnessctl -d amdgpu_bl0 s 7%-
    send_notification
    ;;
esac
