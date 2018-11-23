#!/bin/bash
set -e
set -o pipefail

ERRORS=()

# find all executables and run `shellcheck`
for f in $(find . -type f -not -iwholename '*.git*' -not -iwholename '*.vim*' | sort -u); do
  if file "$f" | grep --quiet shell; then
    {
      shellcheck "$f" && echo -e "\\033[32m[OK]\\033[0m: successfully linted $f"
    } || {
      ERRORS+=("$f")
    }
  fi
done

for f in $(find . -name '*.vim' ! -name '.vim'  ! -path '*autoload*' ! -path '*plugged*' ! -path '*.config*' | sort -u); do
  {
    vint "$f" && echo -e "\\033[32m[OK]\\033[0m: sucessfully linted vim script $f"
  } || {
    ERRORS+=("$f")
  }
done

if [ ${#ERRORS[@]} -eq 0 ]; then
  echo "No errors"
else
  echo "These files failed shellcheck: ${ERRORS[*]}"
  exit 1
fi