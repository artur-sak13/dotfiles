#!/usr/bin/env zsh
###############################################################
# => Prompt
###############################################################

#Oh-My-Zsh Plugins
# shellcheck disable=SC2034
plugins=(
  evalcache
  zsh-nvm
  hacker-quotes
  base16-shell
  nmap
  poetry
  zsh-autosuggestions
  fast-syntax-highlighting
  colored-man-pages
)

# shellcheck source=/dev/null
source "${ZSH}/oh-my-zsh.sh"

# shellcheck source=/dev/null
# source "${HOME}/.zsh/aliases.zsh"

# shellcheck disable=SC1091
# shellcheck source=/usr/local
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# shellcheck disable=SC1091
# shellcheck source=/usr/local
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# shellcheck disable=SC1091
# shellcheck source=/Users/artursak/
[ -s "${HOME}/perl5/perlbrew/etc/bashrc" ] && \. "${HOME}/perl5/perlbrew/etc/bashrc"

# shellcheck disable=SC1091
# shellcheck source=/Users/artursak/
[ -s "${HOMEBREW_PREFIX}/share/zsh/site-functions/aws_zsh_completer.sh" ] && \. "${HOMEBREW_PREFIX}/share/zsh/site-functions/aws_zsh_completer.sh"