# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### common settings start ###
# PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH

# theme
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="agnoster"
# ZSH_THEME="ys"

# plugins
plugins=(tmux git vi-mode wd z extract zsh-syntax-highlighting zsh-autosuggestions)

# basic
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
source ~/.bash_profile

# fzf
source <(fzf --zsh)

# vi-mode
bindkey -v
export KEYTIMEOUT=1

# edit command in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# basic alias
alias cl="clear"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
# custom alias
if [[ -r ~/.alias ]]; then
  source ~/.alias
fi

# using neovim
alias vi='nvim'
export EDITOR='nvim'
alias vimdiff='nvim -d'

### common settings end ###

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# serveo
serveo() {
  if [[ $# -eq 0 ]]; then
    echo "错误：必须指定本地端口号！"
    echo "用法：serveo <本地端口>"
    return 1  # 返回非零状态码表示失败
  fi

  local port="$1"
  # 可选：验证端口是否为有效数字（1-65535）
  if ! [[ "$port" =~ ^[0-9]+$ ]] || ((port < 1 || port > 65535)); then
    echo "错误：端口号必须是 1-65535 之间的整数！"
    return 1
  fi

  # 执行 SSH 端口转发
  ssh -R "serveo.hfxz.link:80:localhost:${port}" serveo.net
}

# ripgrep
alias grep='command rg'

#

# proxy
# export https_proxy=http://127.0.0.1:7890;export http_proxy=http://127.0.0.1:7890;export all_proxy=socks5://127.0.0.1:7890

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# using nvm to control node version
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm use default --silent

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Java - jenv
eval "$(jenv init -)"
