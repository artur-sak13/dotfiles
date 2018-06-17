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


function helmins() {
	kubectl -n kube-system create serviceaccount tiller
	kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
	helm init --service-account=tiller
}

function helmdel() {
	kubectl -n kube-system delete deployment tiller-deploy
    kubectl -n kube-system delete svc tiller-deploy
	kubectl delete clusterrolebinding tiller
	kubectl -n kube-system delete serviceaccount tiller
}

function weaveproxy() { 
	kubectl port-forward -n weave "$(kubectl get -n weave pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
}

function coreos_ver () {
	curl -s https://coreos.com/dist/aws/aws-stable.json | jq -r '.["us-east-2"].hvm'
}

function whatsmyip() {
	dig +short myip.opendns.com @resolver1.opendns.com  
}

function digga() {
	dig +nocmd "$1" any +multiline +noall +answer
}
