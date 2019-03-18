#!/usr/bin/env bash
###############################################################
# => Path
###############################################################

export GOPATH="${HOME}/go"

# shellcheck disable=SC2034
path=(
	"${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin"
	"${HOMEBREW_PREFIX}/opt/findutils/libexec/gnubin"
	"${HOMEBREW_PREFIX}/lib/python2.7/site-packages"
	"${HOMEBREW_PREFIX}/lib/python3.7/site-packages"
	"${HOMEBREW_PREFIX}/Cellar/perl/5.28.0/bin"
	"${HOMEBREW_PREFIX}/opt/imagemagick/bin"
	"${HOMEBREW_PREFIX}/opt/go/libexec/bin"
	"${HOMEBREW_PREFIX}/opt/qt/bin"
	"${HOMEBREW_PREFIX}/go/bin"
	"${HOMEBREW_PREFIX}/sbin"
	"${HOMEBREW_PREFIX}/bin"
	"${GOPATH}/bin"
	"${RBENV_ROOT}/bin"
	"${RBENV_ROOT}/shims"
	"${HOME}/.local/bin"
	"${HOME}/.cargo/bin"
	"${KREW_ROOT:-$HOME/.krew}/bin"
	"${HOME}/Library/Python/3.7/bin"
	"${HOME}/.nvm/versions/node/v10.4.0/bin/npm"
	"${HOME}/.nvm/versions/node/v10.4.0/bin/node"
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
	"${MANPATH}"
)

# shellcheck disable=SC2207
kubeconfigs=($(find "${HOME}/.kube/eksctl/clusters/" -maxdepth 1 -mindepth 1 -type f))
kcs=""
echo "${kubeconfigs[@]}"
for kc in "${kubeconfigs[@]}"; do
	kcs+=":${kc}"
done

export PATH
export MANPATH
export KUBECONFIG="${KUBECONFIG}${kcs}:${HOME}/.kube/config"
