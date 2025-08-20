#!/usr/bin/env zsh
###############################################################
# => Environment
###############################################################

export ITERM2_SQUELCH_MARK=1
# shellcheck source=/dev/null
[ -s "${HOME}/.iterm2_shell_integration.zsh" ] && \. "${HOME}/.iterm2_shell_integration.zsh"

export ZSH="${HOME}/.oh-my-zsh"

export ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"
export ENABLE_CORRECTION=false
# Turn off insecure completion dir
export ZSH_DISABLE_COMPFIX=true

export DOTFILES="${HOME}/dotfiles"
export PROJECTS="${HOME}/projects"

if [[ "$(arch)" == "arm64" ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
else
  export HOMEBREW_PREFIX="/usr/local"
fi

export EDITOR="${HOMEBREW_PREFIX}/bin/nvim"

export AWS_PROFILE=default
export AWS_REGION=us-east-2
export SAM_CLI_TELEMETRY=0

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT=1

if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
  GPG_TTY=$(tty)
  export GPG_TTY
fi

export GAMCFGDIR="${HOME}/GAMConfig"

export MANPAGER="zsh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -l man'"

export GOPATH="${HOME}/go"
export GOBIN="${GOPATH}/bin"
