#!/bin/sh

DIR="$HOME/.config/picom/"

# Kill existing polybar instance
pkill picom

# start new instance
picom --backend glx --config "$DIR"/picom.conf &
