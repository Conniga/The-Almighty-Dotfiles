#!/bin/bash

process_id=$(pidof "cava")

temp=$(mktemp)

pacmd list-source-outputs > $temp

inputs_found=0;
current_index=-1;

while read line; do
   if [ $inputs_found -eq 0 ]; then
      inputs=$(echo -ne "$line" | awk '{print $2}')
      if [[ "$inputs" == "to" ]]; then
         continue
      fi
      inputs_found=1
   else
      if [[ "${line:0:6}" == "index:" ]]; then
         current_index="${line:7}"
      elif [[ "${line:0:25}" == "application.process.id = " ]]; then
         if [[ "${line:25}" == "\"$process_id\"" ]]; then
            #index found...
            break;
         fi
      fi
   fi
done < $temp

rm -f $temp

pactl set-source-output-mute "$current_index" toggle

exit 0