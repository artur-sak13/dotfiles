#!/usr/bin/env bash
###############################################################
# => Environment
###############################################################
export ZSH="${HOME}/.oh-my-zsh"
export ZSH_THEME="lambda-pure"
export ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"
export ENABLE_CORRECTION=false
# Turn off insecure completion dir
export ZSH_DISABLE_COMPFIX=true

export DOTFILES="${HOME}/.dotfiles"

export PYENV_ROOT="${HOME}/.pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

export RBENV_ROOT="${HOME}/.rbenv"

export NVM_DIR="${HOME}/.nvm"

# shellcheck disable=SC1091
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
# shellcheck disable=SC1091
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"

export HOMEBREW_PREFIX="/usr/local"
export EDITOR="${HOMEBREW_PREFIX}/bin/nvim"

export NAME=twopoint.k8s.local
export ZONES=us-east-2a,us-east-2b,us-east-2c
export KOPS_STATE_STORE=s3://twopoint-state-store

export AWS_PROFILE=default
export AWS_REGION=us-east-2

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
	GPG_TTY=$(tty)
	export GPG_TTY
fi
