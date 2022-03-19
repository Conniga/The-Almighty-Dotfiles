#!/usr/bin/env bash

# You can call this script like this:
# $ ./volumeControl.sh up
# $ ./volumeControl.sh down
# $ ./volumeControl.sh mute

# Script modified from these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

function get_volume {
  pamixer --get-volume Master
}

function is_mute {
  pamixer --get-mute Master
}

function send_notification {
  iconSound="~/Downloads/volume-2.svg"
  iconMuted="~/Downloads/volume-x.svg"
  if is_mute ; then
    dunstify --appname="	  	  Volume" -i $iconMuted -r 2593 -u normal "		   Muted"
  else
    volume=$(get_volume)
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq --separator="🮆" 0 "$((volume / 7))" | sed 's/[0-9]//g')
    # Send the notification
    dunstify --appname="		  Volume" -i $iconSound -r 2593 -u normal "$bar"
  fi
}

case $1 in
  up)
    # up the volume (+ 7%)
    pamixer -i 7
    send_notification
    ;;
  down)
    pamixer -d 7
    send_notification
    ;;
  mute)
    # toggle mute
    pamixer -t
    send_notification
    ;;
esac
