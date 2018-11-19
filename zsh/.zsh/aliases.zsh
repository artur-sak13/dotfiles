#!/bin/bash
###############################################################
# => Alises
###############################################################
alias cp="cp -r"
alias scp="scp -r"
alias mkdir="mkdir -p"
alias tree="tree -C"

alias ..="cd .. && ls"
alias ...="cd ../.. && ls"

alias reload='exec ${SHELL} -l'
alias path='echo ${PATH//:/\\n}'

alias grep='grep --color=auto '

# Enable aliases to be sudo’ed
alias sudo='sudo '
alias ssh="gpg-connect-agent updatestartuptty /bye >/dev/null; ssh"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
# source: https://github.com/jessfraz/dotfiles/blob/master/.aliases
alias map="xargs -n1"

for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  # shellcheck disable=SC2139,SC2140
  alias "$method"="lwp-request -m \"$method\""
done

alias whatsmyip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="sudo ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias ips="sudo ifconfig -a | grep -o 'inet6\\? \\(addr:\\)\\?\\s\\?\\(\\(\\([0-9]\\+\\.\\)\\{3\\}[0-9]\\+\\)\\|[a-fA-F0-9:]\\+\\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias iptables-list-all="iptables -vL -t filter && iptables -vL -t nat && iptables -vL -t mangle && iptables -vL -t raw && iptables -vL -t security"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\\: .*|GET \\/.*\""

alias vim="nvim"
alias config="code ~/.dotfiles/zsh/"

alias untar='tar -xvf'
alias hieroglyph="echo -e \"\\033(0\""

if [[ "$OSTYPE" == darwin* ]]; then
  alias startwm="brew services start chunkwm && brew services start khd"
  alias restartwm="brew services restart chunkwm && brew services restart khd"
  alias stopwm="brew services stop chunkwm && brew services stop khd"

  alias cleanupDS="sudo find . -type f -name '*.DS_Store' -ls -delete"
  alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"
  alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

  alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"
  alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
  alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
  alias plistbuddy="/usr/libexec/PlistBuddy"
fi

alias k="kubectl"
alias ksys="kubectl -n kube-system"

# Pipe public key to clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# Pipe private key to clipboard.
alias privkey="more ~/.ssh/id_rsa | pbcopy | echo '=> Private key copied to pasteboard.'"

