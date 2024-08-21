#!/usr/bin/env zsh
###############################################################
# => Zshrc
###############################################################

zmodload zsh/zprof

for config in "${HOME}"/.zsh/*.zsh; do
  # shellcheck source=/dev/null
  source "$config"
done

if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  gpg-connect-agent /bye >/dev/null 2>&1
fi
gpg-connect-agent upstartuptty /bye >/dev/null

GPG_TTY=$(tty)
export GPG_TTY
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

# shellcheck source=/dev/null
[ -s "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ] && \. "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
# shellcheck source=/dev/null
[ -s "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" ] && \. "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
#shellcheck source=/dev/null
[ -s "${HOME}/.travis/travis.sh" ] && \. "${HOME}/.travis/travis.sh"

# shellcheck source=/dev/null
if hash kops 2>/dev/null; then source <(kops completion zsh); fi
# shellcheck source=/dev/null
if hash kubectl 2>/dev/null; then source <(kubectl completion zsh); fi

# shellcheck source=/dev/null
if hash helm 2>/dev/null; then source <(helm completion zsh); fi
# shellcheck source=/dev/null
if hash jx 2>/dev/null; then source <(jx completion zsh); fi

# shellcheck source=/dev/null
source "${HOME}/.bash_completion.d/python-argcomplete.sh"
# shellcheck source=/dev/null
source "${HOMEBREW_PREFIX}/share/zsh/site-functions/aws_zsh_completer.sh"

# pyenv() {
#   set -x
#   unfunction "$0"

#   _evalcache pyenv init --path
#   _evalcache pyenv init -
#   _evalcache pyenv virtualenv-init -

#   $0 "$@"
# }

# _evalcache pyenv init --path
# _evalcache pyenv init -
# _evalcache pyenv virtualenv-init -

eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

eval "$(gh copilot alias -- zsh)"

rbenv() {
  unfunction "$0"

  _evalcache rbenv init -

  $0 "$@"
}

# _evalcache register-python-argcomplete ansible
# _evalcache register-python-argcomplete ansible-config
# _evalcache register-python-argcomplete ansible-console
# _evalcache register-python-argcomplete ansible-doc
# _evalcache register-python-argcomplete ansible-galaxy
# _evalcache register-python-argcomplete ansible-inventory
# _evalcache register-python-argcomplete ansible-playbook
# _evalcache register-python-argcomplete ansible-pull
# _evalcache register-python-argcomplete ansible-vault

if ! unset TMOUT >/dev/null 2>&1; then
  gdb -n <<EOF >/dev/null 2>&1
  attach $$
  call unbind_variable("TMOUT")
  detach
  quit
EOF
fi

# Load Angular CLI autocompletion.
source <(ng completion script)
