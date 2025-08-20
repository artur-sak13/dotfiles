#!/usr/bin/env zsh
###############################################################
# => Path
###############################################################

# shellcheck disable=SC2034
path=(
  "${HOMEBREW_PREFIX}/opt/libiodbc/bin"
  "${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin"
  "${HOMEBREW_PREFIX}/opt/findutils/libexec/gnubin"
  "${HOMEBREW_PREFIX}/opt/gnu-tar/libexec/gnubin"
  "${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin"
  "${HOMEBREW_PREFIX}/opt/make/libexec/gnubin"
  "${HOMEBREW_PREFIX}/opt/gnupg/bin"
  "${HOMEBREW_PREFIX}/opt/imagemagick/bin"
  "${HOMEBREW_PREFIX}/opt/go/libexec/bin"
  "${HOMEBREW_PREFIX}/opt/qt/bin"
  "${HOMEBREW_PREFIX}/go/bin"
  "${HOMEBREW_PREFIX}/sbin"
  "${HOMEBREW_PREFIX}/bin"
  "${GOBIN}"
  "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
  "${HOME}/.local/bin"
  "${HOME}/.cargo/bin"
  "${HOME}/perl5/perlbrew/bin"
  /bin
  /sbin
  /usr/bin
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
