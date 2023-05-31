#!/bin/bash

xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap
(sleep 5s && xset dpms 0 0 3600) &
(sleep 5s && xset r rate 300 30) &
