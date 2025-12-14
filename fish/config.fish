# Proxy
set -gx https_proxy http://127.0.0.1:7890
set -gx http_proxy http://127.0.0.1:7890
set -gx all_proxy socks5://127.0.0.1:7890

# Path
set -U fish_user_paths ~/bin /usr/local/bin $fish_user_paths

# XDG_CONFIG_HOME
set -gx XDG_CONFIG_HOME ~/.config

# Homebrew
if test -d /opt/homebrew
    eval (/opt/homebrew/bin/brew shellenv)
end

if status is-interactive
    # Vim mode
    fish_vi_key_bindings
    set fish_cursor_insert block
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
