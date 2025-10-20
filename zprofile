### proxy ###
export https_proxy=http://127.0.0.1:7890
export http_proxy=http://127.0.0.1:7890
export all_proxy=socks5://127.0.0.1:7890

# PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH

# environment variables
export XDG_CONFIG_HOME="$HOME/.config"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# fzf
source <(fzf --zsh)

# Java - jenv
eval "$(jenv init -)"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
