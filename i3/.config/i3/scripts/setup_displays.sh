#!/bin/bash

INTERNAL_OUTPUT="eDP-1"
EXTERNAL_OUTPUT="HDMI-1"

EXTERNAL_CONNECTED=$(xrandr --listactivemonitors | grep " $EXTERNAL_OUTPUT")

# https://blog.summercat.com/configuring-mixed-dpi-monitors-with-xrandr.html

if [[ $EXTERNAL_CONNECTED != '' ]]; then
    xrandr --dpi 160 --fb 6912x2160 --output eDP-1 --scale 0.9999x0.9999 --mode 3072x1920 --output HDMI-1 --scale 2x2 --pos 3072x0 --panning 3840x2160+3072+0
    # This one works:
    # xrandr --dpi 160 --fb 6912x4080 --output eDP-1 --mode 3072x1920 --output HDMI-1 --scale 2x2 --pos 3072x0 --panning 3840x2160+3072+0
    # xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --right-of $INTERNAL_OUTPUT
else
    xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --off
fi
