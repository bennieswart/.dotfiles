#!/bin/bash

ID=$(xinput list | grep -Eoi 'TouchPad\s*id=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}')
STATE=$(xinput list-props $ID | grep 'Device Enabled' | awk '{print $4}')

if ! [[ $1 =~ ^(on|off|toggle)$ ]]; then
    echo "Usage: $0 <on|off|toggle>"
    exit 1
fi

if [[ $1 == 'on' || ($1 == 'toggle' && $STATE -eq 0) ]]; then
    xinput enable $ID
    echo "Touchpad enabled."
elif [[ $1 == 'off' || ($1 == 'toggle' && $STATE -eq 1) ]]; then
    xinput disable $ID
    echo "Touchpad disabled."
fi
