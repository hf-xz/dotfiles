# Homebrew
if test -d /opt/homebrew
    eval (/opt/homebrew/bin/brew shellenv)

    abbr -a brewClean 'brew cleanup; and brew autoremove'
end
