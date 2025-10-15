#!/usr/bin/env bash
# Current Theme
dir="$HOME/.config/rofi/powermenu/"
theme='style'

# CMDs
uptime="$(uptime -p | sed -e 's/up //g')"
host=$(hostname)

# Options
hibernate='󰛧'
shutdown='⏻ '
reboot=' '
lock=' '
suspend='󰒲 '
logout=''
yes=''
no=''

# Rofi CMD
rofi_cmd() {
  rofi -dmenu \
    -p "  $USER@$host" \
    -mesg "  Uptime: $uptime" \
    -theme ${dir}/${theme}.rasi
}

# Confirmation CMD
confirm_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
    -theme-str 'mainbox {children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 2; lines: 1;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Confirmation' \
    -mesg 'Are you sure?' \
    -theme ${dir}/${theme}.rasi
}

# Ask for confirmation
confirm_exit() {
  echo "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
  echo "$lock\n$suspend\n$logout\n$hibernate\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
  selected="$(confirm_exit)"
  if [[ "$selected" == "$yes" ]]; then
    if [[ $1 == '--shutdown' ]]; then
      loginctl poweroff
    elif [[ $1 == '--reboot' ]]; then
      loginctl reboot
    elif [[ $1 == '--hibernate' ]]; then
      loginctl hibernate
    elif [[ $1 == '--suspend' ]]; then
      betterlockscreen --suspend
    elif [[ $1 == '--logout' ]]; then
      bspc quit
    fi
  else
    exit 0
  fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
$shutdown)
  loginctl poweroff
  ;;
$reboot)
  loginctl reboot
  ;;
$hibernate)
  loginctl hibernate
  ;;
$lock)
  betterlockscreen -l
  ;;
$suspend)
  betterlockscreen --suspend
  ;;
$logout)
  bspc quit
  ;;
esac
