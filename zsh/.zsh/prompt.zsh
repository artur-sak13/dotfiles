#!/bin/bash
###############################################################
# => Prompt
###############################################################

#Oh-My-Zsh Plugins
# shellcheck disable=SC2034
plugins=(
	brew 
	hacker-quotes 
	wd
  base16-shell
  zsh-autosuggestions
	fast-syntax-highlighting
	)

# shellcheck source=/dev/null
source "${ZSH}/oh-my-zsh.sh"
