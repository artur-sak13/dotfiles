###############################################################
# => Alises
###############################################################
alias cp="cp -r"
alias scp="scp -r"
alias mkdir="mkdir -p"
alias tree="tree -C"

alias ..="cd .. && ls"
alias ...="cd ../.. && ls"
alias ....="cd ../../.. && ls"

alias reload="exec ${SHELL} -l"
alias path="echo ${PATH//:/\\n}"

alias ll="ls -lahF --color=auto"
alias lsl="ls -lhF --color=auto"

alias vim="nvim"
alias config="st ~/.zshrc"

alias startwm="brew services start chunkwm && brew services start khd"
alias restartwm="brew services restart chunkwm && brew services restart khd"
alias stopwm="brew services stop chunkwm && brew services stop khd"
alias ckb_restart="echo restart keyboard > /var/run/ckb1/cmd && echo restarted"

alias cleanupDS="sudo find . -type f -name '*.DS_Store' -ls -delete"
alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"