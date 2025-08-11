#!/usr/bin/env bash

set -e
set -o pipefail

SUBKEY_LENGTH=${SUBKEY_LENGTH:=4096}
SUBKEY_EXPIRE=${SUBKEY_EXPIRE:=1}
SURNAME=${SURNAME:="Sak"}
GIVENNAME=${GIVENNAME:="Artur"}
EMAIL=${EMAIL:=$GMAIL}
PUBLIC_KEY_URL=${PUBLIC_KEY_URL:="hkp://keys.openpgp.org"}
KEYID=${KEYID:=$GPGKEY}
SEX=${SEX:=M}

if [[ -z "$KEYID" ]]; then
  echo "Set the KEYID env variable."
  exit 1
fi

if [[ -z "$EMAIL" ]]; then
  echo "Set the EMAIL env variable."
  exit 1
fi

restart_agent() {
  # Restart the gpg agent.
  # shellcheck disable=SC2046
  kill -9 $(pidof scdaemon) >/dev/null 2>&1 || true
  # shellcheck disable=SC2046
  kill -9 $(pidof gpg-agent) >/dev/null 2>&1 || true
  gpg-connect-agent /bye >/dev/null 2>&1 || true
  gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1 || true
}

setup_gnupghome() {
  # Create a temporary directory for GNUPGHOME.
  GNUPGHOME=$(mktemp -d)
  export GNUPGHOME
  echo "Temporary GNUPGHOME is $GNUPGHOME"
  echo "KeyID is ${KEYID}"

  # Create the gpg config file.
  echo "Setting up gpg.conf..."
  cat <<-EOF >"${GNUPGHOME}/gpg.conf"
	no-emit-version
	no-comments
	keyid-format 0xlong
	with-fingerprint
  require-cross-certification
  no-symkey-cache
  throw-keyids
	list-options show-uid-validity
	verify-options show-uid-validity
	use-agent
	charset utf-8
	fixed-list-mode
  keyserver keys.openpgp.org
  keyserver-options no-honor-keyserver-url
  keyserver-options include-revoked
	personal-cipher-preferences AES256 AES192 AES
	personal-digest-preferences SHA512 SHA384 SHA256
  personal-compress-preferences ZLIB BZIP2 ZIP Uncompressed
	cert-digest-algo SHA512
	s2k-cipher-algo AES256
	s2k-digest-algo SHA512
	default-preference-list SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed
	EOF

  echo "Setting up gpg-agent.conf..."
  cat <<-EOF >"${GNUPGHOME}/gpg-agent.conf"
	pinentry-program /usr/local/bin/pinentry-mac
	enable-ssh-support
	default-cache-ttl 3600
  default-cache-ttl-ssh 3600
	max-cache-ttl 7200
  max-cache-ttl-ssh 7200
	use-standard-socket
  write-env-file $HOME/.gnupg/gpg-agent-info
	EOF

  # Copy master key info to GNUPGHOME.
  # IMPORTANT: This is here as a stopper for anyone who runs this without reading it,
  # because it will exit here.
  # Modify this line to copy from a USB stick or your $HOME directory.
  echo "Copying master key from USB..."
  cp gs://misc.j3ss.co/dotfiles/.gnupg/* "${GNUPGHOME}/"

  # Re-import the secret keys.
  gpg --import "${GNUPGHOME}/secring.gpg"

  # Update the default key in the gpg config file.
  echo "default-key ${KEYID}" >>"${GNUPGHOME}/gpg.conf"

  restart_agent
}

validate() {
  if gpg --with-colons --list-key "$KEYID" | grep -q "No public key"; then
    echo "I don't know any key called $KEYID"
    exit 1
  fi
}

generate_subkeys() {
  echo "Printing local secret keys..."
  gpg --list-secret-keys

  echo "Generating subkeys..."

  echo "Generating signing subkey..."
  echo addkey$'\n'4$'\n'$SUBKEY_LENGTH$'\n'"$SUBKEY_EXPIRE"$'\n'save$'\n' |
    gpg --expert --batch --display-charset utf-8 \
      --command-fd 0 --edit-key "$KEYID"

  echo "Generating encryption subkey..."
  echo addkey$'\n'6$'\n'$SUBKEY_LENGTH$'\n'"$SUBKEY_EXPIRE"$'\n'save$'\n' |
    gpg --expert --batch --display-charset utf-8 \
      --command-fd 0 --edit-key "$KEYID"

  echo "Generating authentication subkey..."
  echo addkey$'\n'8$'\n'S$'\n'E$'\n'A$'\n'q$'\n'$SUBKEY_LENGTH$'\n'"$SUBKEY_EXPIRE"$'\n'save$'\n' |
    gpg --expert --batch --display-charset utf-8 \
      --command-fd 0 --edit-key "$KEYID"

  echo "Printing local secret keys..."
  gpg --list-secret-keys
}

move_keys_to_card() {
  echo "Moving signing subkey to card..."
  echo "key 2"$'\n'keytocard$'\n'1$'\n'y$'\n'save$'\n' |
    gpg --expert --batch --display-charset utf-8 \
      --command-fd 0 --edit-key "$KEYID"

  echo "key 3"$'\n'keytocard$'\n'2$'\n'y$'\n'save$'\n' |
    gpg --expert --batch --display-charset utf-8 \
      --command-fd 0 --edit-key "$KEYID"

  echo "key 4"$'\n'keytocard$'\n'3$'\n'y$'\n'save$'\n' |
    gpg --expert --batch --display-charset utf-8 \
      --command-fd 0 --edit-key "$KEYID"

  echo "Printing card status..."
  gpg --card-status
}

update_cardinfo() {
  # Edit the smart card name and info values.
  echo "Updating card holder name..."
  echo admin$'\n'name$'\n'$SURNAME$'\n'$GIVENNAME$'\n'quit$'\n' |
    gpg --expert --batch --display-charset utf-8 \
      --command-fd 0 --card-edit

  echo "Updating card language..."
  echo admin$'\n'lang$'\n'en$'\n'quit$'\n' |
    gpg --expert --batch --display-charset utf-8 \
      --command-fd 0 --card-edit

  echo "Updating card login..."
  echo admin$'\n'login$'\n'"$EMAIL"$'\n'quit$'\n' |
    gpg --expert --batch --display-charset utf-8 \
      --command-fd 0 --card-edit

  echo "Updating card public key url..."
  echo admin$'\n'url$'\n'$PUBLIC_KEY_URL$'\n'quit$'\n' |
    gpg --expert --batch --display-charset utf-8 \
      --command-fd 0 --card-edit

  echo "Updating card sex..."
  echo admin$'\n'sex$'\n'$SEX$'\n'quit$'\n' |
    gpg --expert --batch --display-charset utf-8 \
      --command-fd 0 --card-edit
}

finalize() {
  echo "Printing card status..."
  gpg --card-status

  echo
  echo "Printing local secret keys..."
  gpg --list-secret-keys

  echo
  echo "Temporary GNUPGHOME is $GNUPGHOME"

  gpg --armor --export "$KEYID" >"${HOME}/pubkey.txt"

  echo
  echo "Public key is ${HOME}/pubkey.txt"
  echo "You should upload it to a public key server"

  echo
  echo "Printing ssh key..."
  restart_agent
  ssh-add -L
}

setup_gnupghome
validate
generate_subkeys
move_keys_to_card
update_cardinfo
finalize
