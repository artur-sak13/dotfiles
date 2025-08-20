#!/usr/bin/env bash

set -e
set -o pipefail

# install rust
install_rust() {
	curl https://sh.rustup.rs -sSf | sh
}

install_rosetta() {
	softwareupdate --install-rosetta --agree-to-license
}

# install homebrew
install_homebrew() {
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	# Disable Homebrew analytics
	brew analytics off
	brew bundle install --file="${HOME}/dotfiles/.brew/Brewfile"
}

install_perlbrew() {
	if [[ ! -d "${HOME}/perl5/perlbrew" ]]; then
		curl -L https://install.perlbrew.pl | bash
	fi
}

get_dotfiles() {
	(
		if [[ ! -d "${HOME}/dotfiles" ]]; then
			# install dotfiles from repo
			git clone git@github.com:artur-sak13/dotfiles.git "${HOME}/dotfiles"
		fi

		cd "${HOME}/dotfiles"

		make
	)
}

# install oh-my-zsh
install_oh_my_zsh() {
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	
	chsh -s /bin/zsh "${USER}"
}

usage() {
	echo -e "install-macos.sh\\n\\tThis script installs my setup on macOS based systems.\\n"
	echo "Usage:"
	echo "  dotfiles                             - get dotfiles"
	echo "  homebrew                            - install homebrew and packages"
	echo "  perlbrew                            - install perlbrew"
	echo "  oh-my-zsh                           - install oh-my-zsh"
	echo "  rust                                - install rust"
}

main() {
	local cmd=$1

	if [[ -z "$cmd" ]]; then
		usage
		exit 1
	fi
	install_rosetta
	install_homebrew
	install_oh_my_zsh
	get_dotfiles
	install_perlbrew
	install_rust
}

main "$@"
