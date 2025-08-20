#!/usr/bin/env zsh
###############################################################
# => Prompt
###############################################################

# Oh-My-Zsh Plugins
# shellcheck disable=SC2034
plugins=(
  aliases
  asdf
  base16-shell
  nmap
)

# shellcheck source=/dev/null
source "${ZSH}/oh-my-zsh.sh"

# shellcheck disable=SC1091
# shellcheck source=/Users/artursak/
[ -s "${HOME}/perl5/perlbrew/etc/bashrc" ] && \. "${HOME}/perl5/perlbrew/etc/bashrc"
