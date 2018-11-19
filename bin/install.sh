#!/bin/bash
set -e
set -o pipefail

export DEBIAN_FRONTEND=noninteractive 

# Choose a user account to use for this installation
get_user() {
	if [ -z "${TARGET_USER-}" ]; then
		mapfile -t options < <(find ~/* -maxdepth 0 -printf "%f\\n" -type d)
		# if there is only one option just use that user
		if [ "${#options[@]}" -eq "1" ]; then
			readonly TARGET_USER="${options[0]}"
			echo "Using user account: ${TARGET_USER}"
			return
		fi

		# iterate through the user options and print them
		PS3='Which user account should be used? '

		select opt in "${options[@]}"; do
			readonly TARGET_USER=$opt
			break
		done
	fi
}

check_is_sudo() {
	if [ "$EUID" -ne 0 ]; then
		echo "Please run as root."
		exit
	fi
}

setup_sources_min() {
	apt update || true
	apt install -y \
		apt-transport-https \
		ca-certificates \
		curl \
		dirmngr \
		gnupg2 \
		lsb-release \
		--no-install-recommends

	# hack for latest git
	cat <<-EOF > /etc/apt/sources.list.d/git-core.list
	deb http://ppa.launchpad.net/git-core/ppa/ubuntu xenial main
	deb-src http://ppa.launchpad.net/git-core/ppa/ubuntu xenial main
	EOF

	# neovim
	cat <<-EOF > /etc/apt/sources.list.d/neovim.list
	deb http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu xenial main
	deb-src http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu xenial main
	EOF

	# add the git-core ppa gpg key
	apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys E1DD270288B4E6030699E45FA1715D88E1DF1F24

	# add the neovim ppa gpg key
	apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 9DBB0BE9366964F134855E2255F96FCF8231B6DD

	# add the iovisor/bcc-tools gpg key
	apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 648A4A16A23015EEF4A66B8E4052245BD4284CDD

	# turn off translations, speed up apt update
	mkdir -p /etc/apt/apt.conf.d
	echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/99translations
}

setup_sources() {
	setup_sources_min;

	cat <<-EOF > /etc/apt/sources.list
	deb http://httpredir.debian.org/debian stretch main contrib non-free
	deb-src http://httpredir.debian.org/debian/ stretch main contrib non-free
	deb http://httpredir.debian.org/debian/ stretch-updates main contrib non-free
	deb-src http://httpredir.debian.org/debian/ stretch-updates main contrib non-free
	deb http://security.debian.org/ stretch/updates main contrib non-free
	deb-src http://security.debian.org/ stretch/updates main contrib non-free
	deb http://httpredir.debian.org/debian experimental main contrib non-free
	deb-src http://httpredir.debian.org/debian experimental main contrib non-free
	EOF
}

base_min() {
	apt update || true
	apt -y upgrade

	apt install -y \
		adduser \
		automake \
		bash-completion \
		bc \
		bzip2 \
		ca-certificates \
		coreutils \
		curl \
		dnsutils \
		file \
		findutils \
		gcc \
		git \
		gnupg \
		gnupg2 \
		grep \
		gzip \
		hostname \
		indent \
		iptables \
		jq \
		less \
		libc6-dev \
		locales \
		lsof \
		make \
		mount \
		net-tools \
		neovim \
		ssh \
		strace \
		sudo \
		tar \
		tree \
		tzdata \
		unzip \
		xz-utils \
		zip \
		--no-install-recommends

	apt autoremove
	apt autoclean
	apt clean
}

base() {
	base_min;

	apt update || true
	apt -y upgrade

	apt install -y \
		alsa-utils \
		apparmor \
		bridge-utils \
		cgroupfs-mount \
		fwupd \
		fwupdate \
		gnupg-agent \
		libapparmor-dev \
		libimobiledevice6 \
		libltdl-dev \
		libpam-systemd \
		libseccomp-dev \
		pinentry-curses \
		scdaemon \
		systemd \
		usbmuxd \
		xclip \
		xcompmgr \
		--no-install-recommends

	apt autoremove
	apt autoclean
	apt clean
}

install_homebrew() {
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew bundle install --file="${HOME}/.dotfiles/brew/Brewfile"
}

# install rust
install_rust() {
	curl https://sh.rustup.rs -sSf | sh
}

install_golang() {
  export GO_VERSION
	GO_VERSION=$(curl -sSL "https://golang.org/VERSION?m=text")
	export GO_SRC=/usr/local/go

	if [[ ! -z "$1" ]]; then
		GO_VERSION=$1
	fi

	if [[ -d "$GO_SRC" ]]; then
		sudo rm -rf "$GO_SRC"
	fi
	
	GO_VERSION=${GO_VERSION#go}

	(
		kernel=$(uname -s | tr '[:upper:]' '[:lower:]')
		curl -sSL "https://storage.googleapis.com/golang/go${GO_VERSION}.${kernel}-amd64.tar.gz" | sudo tar -v -C /usr/local -xz
		local user="$USER"
		# rebuild stdlib for faster builds
		sudo chown -R "${user}" /usr/local/go/pkg
		CGO_ENABLED=0 go install -a -installsuffix cgo std
	)

	# get commandline tools
	(
		set -x
		set +e
		go get github.com/golang/lint/golint
		go get golang.org/x/tools/cmd/cover
		go get golang.org/x/review/git-codereview
		go get golang.org/x/tools/cmd/goimports
		go get golang.org/x/tools/cmd/gorename
		go get golang.org/x/tools/cmd/guru

		go get github.com/axw/gocov/gocov
		go get honnef.co/go/tools/cmd/staticcheck
	)

}

get_dotfiles() {
	# create subshell
	(
	cd "$HOME"

	if [[ ! -d "${HOME}/dotfiles" ]]; then
		# install dotfiles from repo
		git clone git@github.com:artur-sak13/dotfiles.git "${HOME}/.dotfiles"
	fi

	cd "${HOME}/.dotfiles"

	# installs all the things
	make

	cd "$HOME"
	)
}

usage() {
	echo -e "install.sh\\n\\tThis script installs setup\\n"
	echo "Usage:"
	echo "  base                                - setup sources & install base pkgs"
	echo "  basemin                             - setup sources & install base min pkgs"
  echo "  homebrew                            - install homebrew"
	echo "  dotfiles                            - get dotfiles"
	echo "  golang                              - install golang and packages"
	echo "  rust                                - install rust"
}

main() {
	local cmd=$1

	if [[ -z "$cmd" ]]; then
		usage
		exit 1
	fi
	if [[ $cmd == "base" ]]; then
		if [[ "$OSTYPE" != darwin* ]]; then
			check_is_sudo
			get_user
			setup_sources
			base
		fi
	elif [[ $cmd == "basemin" ]]; then
		if [[ "$OSTYPE" != darwin* ]]; then
			check_is_sudo
			get_user
			setup_sources_min
			base_min
		fi
	elif [[ $cmd == "dotfiles" ]]; then
		get_user
		get_dotfiles
	elif [[ $cmd == "rust" ]]; then
		install_rust
	elif [[ $cmd == "golang" ]]; then
		install_golang "$2"
	else
		usage
	fi
}

main "$@"

