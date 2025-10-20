# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### antigen setup ###
source /opt/homebrew/share/antigen/antigen.zsh
antigen use oh-my-zsh

# plugins
antigen bundle vi-mode
antigen bundle tmux
antigen bundle git
antigen bundle z
antigen bundle wd
antigen bundle extract
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# theme
antigen theme romkatv/powerlevel10k

antigen apply

# basic alias
alias cl="clear"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# custom alias
if [[ -r ~/.alias ]]; then
  source ~/.alias
fi

# vi-mode
bindkey -v
export KEYTIMEOUT=1

# edit command in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# using neovim
alias vi='nvim'
export EDITOR='nvim'
alias vimdiff='nvim -d'

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
