#!/usr/bin/env bash

# To unstow, use: ./install.sh -D

DIRS=(X i3 zsh tmux nvim)

for d in "${DIRS[@]}"; do
    echo "stow $@ $d"
    stow $@ "$d"
done
