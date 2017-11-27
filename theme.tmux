#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

theme_option="@theme"
default_theme="solarized"

background_option="@theme-background"
default_background="dark"

theme_directory_option="@theme-directory"
default_theme_directory="${XDG_DATA_HOME:-$HOME/.local/share}/tmux/themes"

get_tmux_option() {
  local option_name="$1"
  local default_value="$2"

  local option_value
  option_value="$(tmux show-option -gqv "$option_name")"

  if [[ -z "$option_value" ]]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

locate_theme() {
  local theme="$1"
  local background="$2"

  local plugin_directory
  local user_directory

  plugin_directory="${CURRENT_DIR}/themes"
  user_directory="$(get_tmux_option "$theme_directory_option" "$default_theme_directory")"

  local file
  local candidates=()

  candidates[0]="$user_directory/$theme-$background.conf"
  candidates[1]="$user_directory/$theme.conf"
  candidates[2]="$plugin_directory/$theme-$background.conf"
  candidates[3]="$plugin_directory/$theme.conf"

  for file in "${candidates[@]}"; do
    if [[ -f "$file" ]]; then
      echo "$file"
      break
    fi
  done
}

main() {
  local theme
  local background
  local file

  theme="$(get_tmux_option "$theme_option" "$default_theme")"
  background="$(get_tmux_option "$background_option" "$default_background")"
  file="$(locate_theme "$theme" "$background")"

  if [ -n "$file" ]; then
    tmux source-file "$file"
  else
    tmux display-message "Error! Theme not found"
  fi
}

main
