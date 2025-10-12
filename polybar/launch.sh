#!/bin/sh

DIR="$HOME/.config/polybar/"

# Kill existing polybar instance
pkill polybar

# Launch the bar
polybar -q main -c "$DIR"/config.ini &
