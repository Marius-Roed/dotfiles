# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config//zsh//.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

. "$HOME/.local/bin/env"

# Load aliases from aliasrc file if it exists
[ -f "${ZDOTDIR}/aliasrc" ] && source "${ZDOTDIR}/aliasrc"

# Load options frm optionrc file if it exists
[ -f "${ZDOTDIR}/optionsrc" ] && source "${ZDOTDIR}/optionsrc"

# Custom functions
[ -f "${ZDOTDIR}/functionsrc" ] && source "${ZDOTDIR}/functionsrc"

bindkey "^O" fzf_vim
bindkey "^K" fzf_dir

# Plugins 
source "${ZDOTDIR}/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
source "${ZDOTDIR}/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
source "${ZDOTDIR}/plugins/fsh/fast-syntax-highlighting.plugin.zsh"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=110000
SAVEHIST=100000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/marius/.config/zsh/.zshrc'

bindkey "^ " autosuggest-accept

autoload -Uz compinit
compinit
# End of lines added by compinstall

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

source $ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config//zsh//.p10k.zsh.
[[ ! -f ~/.config//zsh//.p10k.zsh ]] || source ~/.config//zsh//.p10k.zsh

# Make sure Homebrew is on PATH
HOMEBREW_BIN="$(brew --prefix)/bin"

# Prepend Homebrew and remove any duplicates
typeset -U path

path=($HOMEBREW_BIN $path)

source <(fzf --zsh)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# Go
export PATH=$PATH:$HOME/go/bin

# Composer
export PATH=$HOME/.config/composer/vendor/bin:$PATH
