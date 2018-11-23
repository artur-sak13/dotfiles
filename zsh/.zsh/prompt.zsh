#!/bin/bash
###############################################################
# => Prompt
###############################################################

#Oh-My-Zsh Plugins
# shellcheck disable=SC2034
plugins=(
	hacker-quotes 
    base16-shell
	you-should-use
    zsh-autosuggestions
	fast-syntax-highlighting
	)

# shellcheck source=/dev/null
source "${ZSH}/oh-my-zsh.sh"
# shellcheck source=/dev/null
source "${HOME}/.zsh/aliases.zsh"
