function brewup() {
	brew unlink parallel
	brew update
	brew upgrade
	brew cleanup -s
	brew cask outdated | xargs -n1 brew cask reinstall
	brew cask cleanup
	brew prune
	brew link parallel
}

function gemup() {
	gem update --system
	gem update
	gem cleanup
}

function haskup() {
	cabal install cabal cabal-install
	cabal update
	stack update
	stack upgrade
	stack clean
}

function pyup() {
	pip freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install
}

function yarnup() {
	yarn global upgrade
}

function update() {
	brewup
	gemup
	haskup
	yarnup
	pyup
	rustup update
}

function short() {
  curl -F "shorten=$*" https://0x0.st
}