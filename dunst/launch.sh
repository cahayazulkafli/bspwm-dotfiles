#!/bin/sh

DIR="$HOME/.config/dunst/"

# kill the current instance first
pkill dunst

# start new instance
dunst &
