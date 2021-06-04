#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias wald='wal -o "pywal-discord"'

(cat ~/.cache/wal/sequences &)

source ~/.cache/wal/colors-tty.sh

alias cava='cava -p ~/.cache/wal/cavaconfig'

alias neofetch='neofetch --source ~/Pictures/himeno.png --loop'

alias ncmpcpp='mpd & ncmpcpp'
