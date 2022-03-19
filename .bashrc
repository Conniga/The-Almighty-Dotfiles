#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

export PATH=~/.local/bin:$PATH

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias wald='wal -R "pywal-discord"'

(cat ~/.cache/wal/sequences &)

source ~/.cache/wal/colors-tty.sh

alias cava='cava -p ~/.cache/wal/cavaconfig'

alias neofetch='neofetch --source ~/Pictures/A2.jpg --loop'

alias ncmpcpp='mpd & ncmpcpp'

alias ls='ptls'

alias pwd='ptpwd'
