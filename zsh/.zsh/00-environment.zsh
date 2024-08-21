#!/usr/bin/env zsh
###############################################################
# => Environment
###############################################################

export ITERM2_SQUELCH_MARK=1
# shellcheck source=/dev/null
[ -s "${HOME}/.iterm2_shell_integration.zsh" ] && \. "${HOME}/.iterm2_shell_integration.zsh"

export ZSH="${HOME}/.oh-my-zsh"
export ZSH_THEME="spaceship"

SPACESHIP_CHAR_PREFIX="%{$(iterm2_prompt_mark)%}"
export SPACESHIP_CHAR_PREFIX
export SPACESHIP_CHAR_SYMBOL="Ⓐ"
export SPACESHIP_CHAR_SUFFIX="  "
export SPACESHIP_CHAR_COLOR_SUCCESS="cyan"

# export ZSH_THEME="lambda-pure"
export ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"
export ENABLE_CORRECTION=false
# Turn off insecure completion dir
export ZSH_DISABLE_COMPFIX=true

export DOTFILES="${HOME}/dotfiles"
export PROJECTS="${HOME}/projects"
export HOMEBREW_PREFIX="/usr/local"

export PYENV_ROOT="${HOME}/.pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

export RBENV_ROOT="${HOME}/.rbenv"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

export NVM_DIR="${HOME}/.nvm"
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
export NVM_AUTO_USE=true

export EDITOR="${HOMEBREW_PREFIX}/bin/nvim"

export AWS_PROFILE=default
export AWS_REGION=us-east-2
export SAM_CLI_TELEMETRY=0

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export BAT_PAGER=""

export CLOUDSDK_PYTHON=/usr/bin/python3
export FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT=1

if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
  GPG_TTY=$(tty)
  export GPG_TTY
fi
