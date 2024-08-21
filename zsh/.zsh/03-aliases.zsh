#!/usr/bin/env zsh
###############################################################
# => Alises
###############################################################
# shellcheck source=/dev/null
if hash bat 2>/dev/null; then
  alias cat="bat --paging=never"
fi

if hash eza 2>/dev/null; then
  alias ls="eza -ahF --color always"
else
  alias ls="ls -ahF --color"
fi

alias cp="cp -r"
alias scp="scp -r"
alias mkdir="mkdir -p"
alias tree="tree -C"

alias psusers="ps hax -o user | sort | uniq -c | sort -r"

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
alias credsniff="sudo tcpdump port http or port ftp or port smtp or port imap or port pop3 or port telnet -lA | egrep -i -B5 'pass=|pwd=|log=|login=|user=|username=|pw=|passw=|passwd=|password=|pass:|user:|username:|password:|login:|pass |user '"
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\\: .*|GET \\/.*\""

alias vim="nvim"
alias code="code-insiders"
alias dots='code-insiders ${DOTFILES}'

alias untar='tar -xvf'
alias hieroglyph="echo -e \"\\033(0\""

if [[ "$OSTYPE" == darwin* ]]; then
  alias startwm="brew services start chunkwm && brew services start khd"
  alias restartwm="brew services restart chunkwm && brew services restart khd"
  alias stopwm="brew services stop chunkwm && brew services stop khd"

  alias cleanupDS="sudo find . -type f -name '*.DS_Store' -ls -delete"
  alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"
  alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

  alias flush="sudo killall -HUP mDNSResponder"
  alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
  alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
  alias plistbuddy="/usr/libexec/PlistBuddy"
  alias lsusb="ioreg -p IOUSB -w0 | sed 's/[^o]*o //; s/@.*$//' | grep -v '^Root.*'"
fi

alias k="kubectl"
alias ksys="kubectl -n kube-system"

# Pipe public key to clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# Pipe private key to clipboard.
alias privkey="more ~/.ssh/id_rsa | pbcopy | echo '=> Private key copied to pasteboard.'"

alias gam="${HOME}/bin/gamadv-xtd3/gam"

alias work="cd ${PROJECTS}/twopt/"
alias personal="cd ${PROJECTS}/$(git config user.name)/"
alias oss="cd ${PROJECTS}/oss/"

alias secure_input_user="ioreg -l -w 0 |  tr ',' '\n' 2&> /dev/null | grep kCGSSessionSecureInputPID | cut -f 2 -d = | uniq | xargs ps -o command= -p"

alias gam="${HOME}/bin/gam/gam"
alias gam="${HOME}/bin/gamadv-xtd3/gam"
