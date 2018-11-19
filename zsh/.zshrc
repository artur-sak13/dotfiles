#!/bin/bash
###############################################################
# => Zshrc
###############################################################
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

# shellcheck source=/dev/null
if [ -f "${HOME}/.nvm/nvm.sh" ]; then source "${HOME}/.nvm/nvm.sh"; fi
# shellcheck source=/dev/null
if [ -f "${HOME}/.iterm2_shell_integration.zsh" ]; then source "${HOME}/.iterm2_shell_integration.zsh"; fi
# shellcheck source=/dev/null
if [ -f "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ]; then source "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"; fi
# shellcheck source=/dev/null
if [ -f "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" ]; then source "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"; fi
#shellcheck source=/dev/null
if [ -f "${HOME}/.travis/travis.sh" ]; then source "${HOME}/.travis/travis.sh"; fi

# shellcheck source=/dev/null
source <(kops completion zsh)
# shellcheck source=/dev/null
source <(kubectl completion zsh)

# shellcheck source=/dev/null
if hash helm 2>/dev/null; then source <(helm completion zsh); fi

if hash pyenv 2>/dev/null; then eval "$(pyenv init -)"; fi
if hash rbenv 2>/dev/null; then eval "$(rbenv init -)"; fi


if ! unset TMOUT > /dev/null 2>&1; then
    gdb <<EOF > /dev/null 2>&1
 attach $$
 call unbind_variable("TMOUT")
 detach
 quit
EOF
fi




