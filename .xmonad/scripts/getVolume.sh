#!/bin/bash

PATH_TO_PIPE="/home/$USER/.xmonad/scripts/volume-info"
getMaster=$( /usr/bin/amixer -c 0 get Master,0 | `
            `/usr/bin/awk 'END{print $6,$4}' | tr -d '[]' )

echo $getMaster > $PATH_TO_PIPE # Update info to status bar

#if [[ $getMaster =~ "0%" && $getMaster =~ "on" ]]
#then
#    /usr/bin/amixer set Master toggle
#    echo $getMaster > $PATH_TO_PIPE # Update info to status bar
##    echo "${getMaster/off/}" > $PATH_TO_PIPE
##    if [[ $getMaster =~ "on" ]]
##    then
##        echo "${getMaster/on/}" > $PATH_TO_PIPE
##    elif [[ $getMaster =~ "off" ]]; then
##        echo "${getMaster/off/}" > $PATH_TO_PIPE
##    fi
#fi

# TO DO FOR CAPTURE DEVICE
#/usr/bin/amixer -c 0 get Capture,0 | /usr/bin/awk 'END{print $5,$7}' \
#> /home/$USER/.xmonad/scripts/volume-info3
