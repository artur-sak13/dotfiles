#!/usr/bin/env zsh
###############################################################
# => Path
###############################################################

export GOPATH="${HOME}/go"
export GOBIN="${GOPATH}/bin"

# shellcheck disable=SC2034
path=(
  "${HOMEBREW_PREFIX}/opt/libiodbc/bin"
  "${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin"
  "${HOMEBREW_PREFIX}/opt/findutils/libexec/gnubin"
  "${HOMEBREW_PREFIX}/opt/gnu-tar/libexec/gnubin"
  "${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin"
  "${HOMEBREW_PREFIX}/opt/make/libexec/gnubin"
  "${HOMEBREW_PREFIX}/lib/python3.9/site-packages"
  "${HOMEBREW_PREFIX}/Cellar/perl/5.28.0/bin"
  "${HOMEBREW_PREFIX}/opt/gnupg@2.2/bin"
  "${HOMEBREW_PREFIX}/opt/imagemagick/bin"
  "${HOMEBREW_PREFIX}/opt/go/libexec/bin"
  "${HOMEBREW_PREFIX}/opt/qt/bin"
  "${HOMEBREW_PREFIX}/go/bin"
  "${HOMEBREW_PREFIX}/sbin"
  "${HOMEBREW_PREFIX}/bin"
  "${GOPATH}/bin"
  "${PYENV_ROOT}/bin"
  "${RBENV_ROOT}/bin"
  "${RBENV_ROOT}/shims"
  "${HOME}/.local/bin"
  "${HOME}/.cargo/bin"
  "${KREW_ROOT:-$HOME/.krew}/bin"
  "${HOME}/.fastlane/bin"
  "${HOME}/.nvm/versions/node/v18.10.0/bin/npm"
  "${HOME}/.nvm/versions/node/v18.10.0/bin/node"
  "${HOME}/perl5/perlbrew/bin"
  /bin
  /sbin
  /usr/bin
  /usr/games
  /usr/sbin
  /opt/X11/bin
)

# shellcheck disable=SC2034
manpath=(
  "${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnuman"
  "${HOMEBREW_PREFIX}/opt/findutils/libexec/gnuman"
  "${HOMEBREW_PREFIX}/opt/make/libexec/gnuman"
  "${HOMEBREW_PREFIX}/opt/grep/libexec/gnuman"
  "${HOMEBREW_PREFIX}/opt/gnu-tar/libexec/gnuman"
  "${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnuman"
  "${MANPATH}"
)

export PATH
export MANPATH
