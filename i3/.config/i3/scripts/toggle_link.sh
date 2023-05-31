#!/bin/bash

# Ensure that your user can run sudo ip link set <dev> up|down with passwordless sudo.

if [[ $1 == '' ]]; then
    echo "Usage: $0 <dev>"
    exit 1
fi

if [[ $(ip -br link show "$1" | awk '{print $2}') == DOWN ]]; then
    sudo ip link set "$1" up
else
    sudo ip link set "$1" down
fi
