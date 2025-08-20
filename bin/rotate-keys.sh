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
USB_MOUNT=${USB_MOUNT:="/Volumes/USB"}

if [[ -z "$KEYID" ]]; then
	echo "Set the KEYID env variable."
	exit 1
fi

if [[ -z "$EMAIL" ]]; then
	echo "Set the EMAIL env variable."
	exit 1
fi

if [[ ! -d "$USB_MOUNT/.gnupg" ]]; then
	echo "No .gnupg directory found on USB at $USB_MOUNT"
	exit 1
fi

restart_agent() {
	echo "Restarting gpg-agent..."
	# Restart the gpg agent.
	pkill -9 -x scdaemon 2>/dev/null || true

	pkill -9 -x gpg-agent 2>/dev/null || true

	gpg-connect-agent /bye >/dev/null 2>&1 || true
	gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1 || true
}

setup_gnupghome() {
	# Create a temporary directory for GNUPGHOME.
	GNUPGHOME=$(mktemp -d)
	export GNUPGHOME

	echo "Temporary GNUPGHOME is $GNUPGHOME"
	echo "KeyID is ${KEYID}"

	echo "Copying master key from USB..."
	cp -r "${USB_MOUNT}/.gnupg/"* "${GNUPGHOME}/"

	if [[ ! -d "${GNUPGHOME}/private-keys-v1.d" ]]; then
		echo "private-keys-v1.d not found on USB copy"
		exit 1
	fi

	chmod 700 "${GNUPGHOME}/private-keys-v1.d"
	chmod 600 "${GNUPGHOME}/private-keys-v1.d/"*

	# Update the default key in the gpg config file.
	sed -i "s/^default-key .*/default-key ${KEYID}/" "${GNUPGHOME}/gpg.conf"

	restart_agent
}

validate() {
	if gpg --with-colons --list-key "$KEYID" | grep -qF "No public key"; then
		echo "I don't know any key called $KEYID"
		exit 1
	fi
}

generate_subkeys() {
	echo "Printing local secret keys..."
	gpg --list-secret-keys

	echo "Generating subkeys..."

	echo "Generating signing subkey..."
	gpg --expert \
		--batch \
		--display-charset utf-8 \
		--command-fd 0 \
		--edit-key "$KEYID" <<-EOF
			addkey
			4
			$SUBKEY_LENGTH
			$SUBKEY_EXPIRE
			save
		EOF

	echo "Generating encryption subkey..."
	gpg --expert \
		--batch \
		--display-charset utf-8 \
		--command-fd 0 \
		--edit-key "$KEYID" <<-EOF
			addkey
			6
			$SUBKEY_LENGTH
			$SUBKEY_EXPIRE
			save
		EOF

	echo "Generating authentication subkey..."
	gpg --expert \
		--batch \
		--display-charset utf-8 \
		--command-fd 0 \
		--edit-key "$KEYID" <<-EOF
			addkey
			8
			S
			E
			A
			q
			$SUBKEY_LENGTH
			$SUBKEY_EXPIRE
			save
		EOF

	echo "Printing local secret keys..."
	gpg --list-secret-keys
}

move_keys_to_card() {
	echo "Moving subkeys to smarcard by fingerprint..."
	# List subkeys with their capabilities and fingerprints.
	mapfile -t subkeys < <(gpg --list-secret-keys --with-subkey-fingerprint --with-colons "$KEYID" |
		awk -F: '/^sub/{cap=$12} /^fpr/{print cap ":" $10}')

	declare -A slots
	# Define slots for each capability.
	# s = signing, e = encryption, a = authentication
	slots=([s]=1 [e]=2 [a]=3)

	for key in "${subkeys[@]}"; do
		capabilities=${key%%:*}
		fingerprint=${key##*:}

		for capability in s e a; do
			if [[ "$capabilities" == *"$capability"* && -n "${slots[$capability]}" ]]; then
				slot=${slots[$capability]}

				echo "Moving subkey $fingerprint(cap $capability) to slot $slot"

				gpg --expert \
					--batch \
					--yes \
					--display-charset utf-8 \
					--command-fd 0 \
					--edit-key "$KEYID" <<-EOF
						key $fingerprint
						keytocard
						$slot
						y
						save
					EOF

				# Prevent mapping the same slot twice.
				unset 'slots[$capability]'
			fi
		done
	done

	echo "Printing card status..."
	gpg --card-status
}

update_cardinfo() {
	# Edit the smart card name and info values.
	echo "Updating card holder name..."
	gpg --expert \
		--batch \
		--display-charset utf-8 \
		--command-fd 0 \
		--card-edit <<-EOF
			admin
			name
			$SURNAME
			$GIVENNAME
			quit
		EOF

	echo "Updating card language..."
	gpg --expert \
		--batch \
		--display-charset utf-8 \
		--command-fd 0 \
		--card-edit <<-EOF
			admin
			lang
			en
			quit
		EOF

	echo "Updating card login..."
	gpg --expert \
		--batch \
		--display-charset utf-8 \
		--command-fd 0 \
		--card-edit <<-EOF
			admin
			login
			$EMAIL
			quit
		EOF

	echo "Updating card public key url..."
	gpg --expert \
		--batch \
		--display-charset utf-8 \
		--command-fd 0 \
		--card-edit <<-EOF
			admin
			url
			$PUBLIC_KEY_URL
			quit
		EOF

	echo "Updating card sex..."
	gpg --expert \
		--batch \
		--display-charset utf-8 \
		--command-fd 0 \
		--card-edit <<-EOF
			admin
			sex
			$SEX
			quit
		EOF
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

	restart_agent
	echo
	echo "SSH keys available via agent:"
	ssh-add -L
}

setup_gnupghome
validate
generate_subkeys
move_keys_to_card
update_cardinfo
finalize
