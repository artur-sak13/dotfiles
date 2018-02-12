###############################################################
# => Zshrc
###############################################################
for config ($HOME/.zsh/*.zsh) source $config
source "$HOME/.nvm/nvm.sh"
source "$HOME/.iterm2_shell_integration.zsh"

eval "$(pyenv init -)"
eval "$(rbenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(thefuck --alias)"

