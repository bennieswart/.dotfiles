#!/usr/bin/env bash

# To unstow, use: ./install.sh -D

DIRS=(nvim tmux)

for d in "${DIRS[@]}"; do
    echo "stow $@ $d"
    stow $@ "$d"
done
