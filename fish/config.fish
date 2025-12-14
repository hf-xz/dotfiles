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

# fnm
if test -e /opt/homebrew/bin/fnm
    eval (/opt/homebrew/bin/fnm env)
end

if status is-interactive
    # Vim mode
    fish_vi_key_bindings
    set fish_cursor_insert block

    # Starship
    starship init fish | source
    enable_transience

    # workaround https://github.com/starship/starship/issues/560
    function starship_transient_prompt_func
        tput cuu1
        starship module character
    end

    function prompt_newline --on-event fish_postexec
        echo
    end

    alias clear "command clear; commandline -f clear-screen"
    alias cl "command clear; commandline -f clear-screen"
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
