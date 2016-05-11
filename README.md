# Tmux Theme

TMUX plugin that allows easy switching of tmux color themes.

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    # ~/.tmux.conf
    set -g @plugin "dweidner/tmux-theme"

Hit `prefix + I` to fetch the plugin and source it. You should now be able to use the plugin.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/dweidner/tmux-theme ~/.tmux/plugins/tmux-theme

Add this line to the bottom of `.tmux.conf`:

    # ~/.tmux.conf
    run-shell "~/.tmux/plugins/tmux-theme/theme.tmux"

Reload your TMUX environment with `$ tmux source-file ~/.tmux.conf`. You should now be able to use the plugin.

### Configuration

**Default Theme**
  
    # ~/.tmux.conf
    set -g @theme "solarized"
    set -g @theme-background "dark"

**Custom Theme Directory**
The plugin tries to load themes from a user directory first before falling back to the ones shipped with the plugin.

    # ~/.tmux.conf
    set -g @theme-directory "~/.tmux/themes"

### License

[MIT](LICENSE.md)

