#!/bin/bash

process_id=$(pidof "cava")

temp=$(mktemp)

pactl list source-outputs > $temp

inputs_found=0;
current_index=-1;

while read line; do
   if [ $inputs_found -eq 0 ]; then
      inputs=$(echo -ne "$line" | awk '{print $2}')
      if [[ "$inputs" == "to" ]]; then
         echo "$inputs"
         continue
      fi
      inputs_found=1
   else
      if [[ "${line:0:25}" == "application.process.id = " ]]; then
         if [[ "${line:25}" == "\"$process_id\"" ]]; then
            while read line; do
                if [[ "${line:0:16}" == "object.serial = " ]]; then
                    current_index=${line:16}
                    break    
                fi
            done
         break
         fi
      fi
   fi
done < $temp

rm -f $temp

indextemp="${current_index%\"}"
indextemp="${indextemp#\"}"

pactl set-source-output-mute "$indextemp" toggle

exit 0