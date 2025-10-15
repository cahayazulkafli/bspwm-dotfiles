#!/bin/sh

DIR="$HOME/.config/sxhkd/"

# Kill existing sxhkd instance
pkill sxhkd

# start new instance
sxhkd &
