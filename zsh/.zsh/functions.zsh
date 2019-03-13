#!/usr/bin/env bash
###############################################################
# => Functions
###############################################################

# Update homebrew packages
brewup() {
	brew update
	brew upgrade
	brew cleanup -s
	brew cask upgrade
}

kalloc() {
	kubectl get po --all-namespaces -o=jsonpath="{range .items[*]}{.metadata.namespace}:{.metadata.name}{'\\n'}{range .spec.containers[*]}  {.name}:{.resources.requests.cpu}{'\\n'}{end}{'\\n'}{end}"
}
# nullpointer url shortener
# source: https://github.com/xero/dotfiles/blob/master/zsh/.zsh/aliases.zsh
short() {
	curl -F "shorten=$*" https://0x0.st
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
# source: https://github.com/jessfraz/dotfiles/blob/master/.functions
json() {
	if [ -t 0 ]; then # argument
		python -mjson.tool <<< "$*" | pygmentize -l javascript
	else # pipe
		python -mjson.tool | pygmentize -l javascript
	fi
}

# Show all the names (CNs and SANs) listed in the SSL 
# certificate for a given domain
# source: https://github.com/jessfraz/dotfiles/blob/master/.functions
getcertnames() {
	if [ -z "${1}" ]; then
		echo "ERROR: No domain specified."
		return 1
	fi

	local domain="${1}"
	echo "Testing ${domain}…"
	echo ""; # newline

	local tmp
	tmp=$(echo -e "GET / HTTP/1.0\\nEOT" \
					| openssl s_client -connect "${domain}:443" 2>&1)

	if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
		local certText
		certText=$(echo "${tmp}" \
						| openssl x509 -text -certopt "no_header, no_serial, no_version, \
						no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux")

		echo "Common Name:"
		echo ""; # newline
		echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//"
		echo ""; # newline
		echo "Subject Alternative Name(s):"
		echo ""; # newline
		echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
						| sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\\n" | tail -n +2
		return 0
	else
		echo "ERROR: Certificate not found."
		return 1
	fi
}

# Go up 'n' number of directories
# Usage: `up 4` will go up 4 directories
up() {
	if [[ "$#" -ne 1 ]]; then
		cd ..
	elif ! [[ $1 =~ ^[0-9]+$ ]]; then
		echo "Error: up should be called with the number of directories to go up. The default is 1."
	else
		local d=""
		limit=$1
		for ((i=1; i <= limit; i++))
			do
				d=$d/..
			done
		d=$(echo $d | sed 's/^\///')
		cd "$d" || exit
	fi
}

# Colored man pages
# source: https://github.com/jessfraz/dotfiles/blob/master/.functions
man() {
	env \
			LESS_TERMCAP_mb="$(printf '\e[01;31m')" \
			LESS_TERMCAP_md="$(printf '\e[01;38;5;74m')" \
			LESS_TERMCAP_me="$(printf '\e[0m')" \
			LESS_TERMCAP_se="$(printf '\e[0m')" \
			LESS_TERMCAP_so="$(printf '\e[38;33;246m')" \
			LESS_TERMCAP_ue="$(printf '\e[0m')" \
			LESS_TERMCAP_us="$(printf '\e[04;38;5;146m')" \
			man "$@"
}

# Call from a local repo to open the repository on github/gitlab
# Modified version of https://github.com/jessfraz/dotfiles/blob/master/.functions
repo() {
	local base_url
	base_url=$(git config --get remote.origin.url)
	# strip .git from end of url
	base_url=${base_url%\.git}

	base_url=${base_url//git@github\.com:/https:\/\/github\.com\/}

	# Fix git@gitlab.com: URLs
	base_url=${base_url//git@gitlab\.com:/https:\/\/gitlab\.com\/}

	# Fix git@gitlab.com: URLs
	base_url=${base_url//git@gitlab\.twopoint\.io:/https:\/\/gitlab\.twopoint\.io\/}

	# Validate that this folder is a git folder
	if ! git branch 2>/dev/null 1>&2 ; then
		echo "Not a git repo!"
		exit $?
	fi

	# Find current directory relative to .git parent
	full_path=$(pwd)
	git_base_path=$(cd "./$(git rev-parse --show-cdup)" || exit 1; pwd)
	relative_path=${full_path#$git_base_path} # remove leading git_base_path from working directory

	# If filename argument is present, append it
	if [ "$1" ]; then
		relative_path="$relative_path/$1"
	fi

	# Figure out current git branch
	# git_where=$(command git symbolic-ref -q HEAD || command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null
	git_where=$(command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null

	# Remove cruft from branchname
	branch=${git_where#refs\/heads\/}

	url="$base_url/tree/$branch$relative_path"

	echo "Calling $(type open) for $url"
	open "$url" &> /dev/null || (echo "Using $(type open) to open URL failed." && exit 1);
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
# source: https://github.com/jessfraz/dotfiles/blob/master/.functions
tre() {
	tree -aC -I '.git' --dirsfirst "$@" | less -FRNX
}

# check if uri is up
# source: https://github.com/jessfraz/dotfiles/blob/master/.functions
isup() {
	local uri=$1

	if curl -s --head  --request GET "$uri" | grep "200 OK" > /dev/null ; then
		notify-send --urgency=critical "$uri is down"
	else
		notify-send --urgency=low "$uri is up"
	fi
}

# Install tiller in Kubernetes cluster and assign it to a service account with cluster-admin privileges
# From @pczarkowski see full article below
# https://medium.com/@pczarkowski/easily-install-uninstall-helm-on-rbac-kubernetes-8c3c0e22d0d7
helmins() {
	kubectl -n kube-system create serviceaccount tiller
	kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
	helm init --service-account=tiller
}
# Uninstall tiller from Kubernetes cluster
helmdel() {
	kubectl -n kube-system delete deployment tiller-deploy
  kubectl -n kube-system delete svc tiller-deploy
	kubectl delete clusterrolebinding tiller
	kubectl -n kube-system delete serviceaccount tiller
}
# Create new repository in gitlab from the command line
gitnew() {
	git push --set-upstream git@github.com:artur-sak13/"$(git rev-parse --show-toplevel | xargs basename).git" "$(git rev-parse --abbrev-ref HEAD)"
}

# Port forward weave scope pod
weaveproxy() { 
	kubectl port-forward -n weave "$(kubectl get -n weave pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
}

# Get latest Container Linux HVM ami-id
coreosver () {
	curl -s https://coreos.com/dist/aws/aws-stable.json | jq -r '.["us-east-2"].hvm'
}

# Kill ckb-next daemon to restore dat RGB goodness
ckbkill() {
  sudo killall -KILL ckb-next-daemon
}

# Display only the most useful info when running `dig`
# source: https://github.com/jessfraz/dotfiles/blob/master/.functions
digga() {
	dig +nocmd "$1" any +multiline +noall +answer
}

# Run comprehensive nmap
fukmap() {
	sudo nmap -n -Pn -sSU -pT:0-65535,U:0-65535 -v -A -oX results.xt "$1"
}

# Tar compress with progress bar
tbar() {
	local tar=$1
	local dir=$2
	tar -cvzf "$tar" "$dir" | tqdm --unit_scale --total "$(find "$dir" -type f | wc -l )" > /dev/null
}

restart_gpgagent() {
	# shellcheck disable=SC2046
	kill -9 $(pidof scdaemon) >/dev/null 2>&1
	# shellcheck disable=SC2046
	kill -9 $(pidof gpg-agent) >/dev/null 2>&1
	gpg-connect-agent /bye >/dev/null 2>&1
	gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
}