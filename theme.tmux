#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

theme_option="@theme"
default_theme="solarized"

background_option="@theme-background"
default_background="light"

theme_directory_option="@theme-directory"
default_theme_directory="$HOME/.tmux/themes"

get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value=$(tmux show-option -gqv "$option")
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

locate_theme() {
  local theme="$1"
  local background="$2"

  local user_directory="$(get_tmux_option "$theme_directory_option" "$default_theme_directory")"
  local plugin_directory="$CURRENT_DIR/themes"

  local theme_file
  local theme_candidates=()
  theme_candidates[0]="$user_directory/$theme-$background.conf"
  theme_candidates[1]="$user_directory/$theme.conf"
  theme_candidates[2]="$plugin_directory/$theme-$background.conf"
  theme_candidates[3]="$plugin_directory/$theme.conf"

  for theme_file in "${theme_candidates[@]}"; do
    if [ -f "$theme_file" ]; then
      echo "$theme_file"
      break
    fi
  done
}

main() {
  local theme="$(get_tmux_option "$theme_option" "$default_theme")"
  local background="$(get_tmux_option "$background_option" "$default_background")"

  local theme_file="$(locate_theme "$theme" "$background")"
  if [ -n "$theme_file" ]; then
    tmux source-file "$theme_file"
  else
    tmux display-message "Error! Theme file not found"
  fi
}

main
