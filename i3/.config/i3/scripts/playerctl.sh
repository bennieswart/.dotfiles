#!/bin/bash

if ! [[ $1 =~ ^(toggle|select)$ ]]; then
    echo "Usage: $0 <toggle|select [name]>"
    exit 1
fi

OPTFILE="$(dirname $0)/.playerctl_options"

IFS=$'\n' read -d '' -a PLAYERS <<< "$(playerctl --list-all)"
NUM=${#PLAYERS[@]}

if [[ $1 == 'select' ]]; then
    if [[ $2 == '' ]]; then
        # Get the list of players and prompt for one to select.
        prompt='Default player: '
        
        echo -n > $OPTFILE
        for (( i = 0; i < $NUM; i++ )); do
            prompt="$prompt ($((i+1))) ${PLAYERS[$i]}"
            echo "${PLAYERS[$i]}" >> $OPTFILE
        done
        
        i3-input -F "exec --no-startup-id $0 select %s" -l 1 -P "$prompt"
    else
        # Select the specified player.
        player=$(awk "NR==$2{ print; exit }" $OPTFILE)
        for p in "${PLAYERS[@]}"; do
            if [[ "$p" == "$player" ]]; then
                break
            fi
            playerctld shift
        done
    fi
else
    # If anything is playing, pause everything.
    if playerctl --all-players status | grep -qi Playing; then
        playerctl --all-players pause
    else
        playerctl play-pause
    fi
fi
