#!/usr/bin/env zsh
###############################################################
# => Zshrc
###############################################################

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

for config in "${HOME}"/.zsh/*.zsh; do
  # shellcheck source=/dev/null
  source "$config"
done

if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  gpg-connect-agent /bye >/dev/null 2>&1
fi
gpg-connect-agent upstartuptty /bye >/dev/null

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  if [[ -z "$SSH_AUTH_SOCK" ]] || [[ "$SSH_AUTH_SOCK" == *"apple.launchd"* ]]; then
    SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    export SSH_AUTH_SOCK
  fi
fi

setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_save_no_dups

eval "$(starship init zsh)"
eval "$(gh copilot alias -- zsh)"

if ! unset TMOUT >/dev/null 2>&1; then
  gdb -n <<EOF >/dev/null 2>&1
  attach $$
  call unbind_variable("TMOUT")
  detach
  quit
EOF
fi
