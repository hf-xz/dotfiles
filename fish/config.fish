# XDG_CONFIG_HOME
set -gx XDG_CONFIG_HOME ~/.config

# Path
set -U fish_user_paths ~/bin /usr/local/bin $fish_user_paths

if status is-interactive
    # Vim mode
    fish_vi_key_bindings
    set fish_cursor_insert block

    # No greeting
    set fish_greeting
end
