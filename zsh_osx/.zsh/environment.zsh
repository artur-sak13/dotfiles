###############################################################
# => Environment
###############################################################
export ZSH="$HOME/.oh-my-zsh"
export DOTFILES="$HOME/.dotfiles"
export PYENV_ROOT="$HOME/.pyenv"
export RBENV_ROOT="$HOME/.rbenv"
export NVM_DIR="$HOME/.nvm"
export HOMEBREW_PREFIX="/usr/local"


export AWS_REGION=us-east-2
export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)
export KOPS_STATE_STORE=s3://twopoint-state-store
export NAME=twopoint.k8s.local
export ZONES=us-east-2a,us-east-2b,us-east-2c

export PYENV_VIRTUALENV_DISABLE_PROMPT=1

path=(
	$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin
	$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin
	$HOMEBREW_PREFIX/opt/imagemagick/bin
	$HOMEBREW_PREFIX/opt/go/libexec/bin
	$HOMEBREW_PREFIX/opt/qt/bin
	$HOMEBREW_PREFIX/bin
	$PYENV_ROOT/bin
	$PYENV_ROOT/shims
	$RBENV_ROOT/bin
	$RBENV_ROOT/shims
	$HOME/.local/bin
	$HOME/.cargo/bin
	$HOME/.nvm/versions/node/v9.5.0/bin/node
	$HOME/.nvm/versions/node/v9.5.0/bin/npm
	$HOME/Library/Haskell/bin
	/bin
	/sbin
	/usr/bin
	/usr/sbin
	/opt/X11/bin
	)

manpath=(
	$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman
	$HOMEBREW_PREFIX/opt/findutils/libexec/gnuman
	)

export PATH
export MANPATH

export EDITOR=nvim

export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LESSCHARSET=utf-8
