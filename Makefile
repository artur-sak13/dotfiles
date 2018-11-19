PREFIX?=$(shell pwd)

.PHONY: bin
bin: ## Installs the bin directory files.
			# create symlinks for files in bin
			for file in $(shell find $(CURDIR)/bin -type f); do \
							f=$$(basename $$file); \
							sudo ln -sf $$file /usr/local/bin/$$f; \
			done

.PHONY: dotfiles
dotfiles: ## Installs the dotfiles.
			# add aliases for dotfiles
			for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".travis.yml" -not -name ".git" -not -name ".gnupg"); do \
							f=$$(basename $$file); \
							ln -sfn $$file $(HOME)/$$f; \
			done; \
			gpg --list-keys || true;
			ln -sfn $(CURDIR)/.gnupg/gpg.conf $(HOME)/.gnupg/gpg.conf;
			ln -sfn $(CURDIR)/.gnupg/gpg-agent.conf $(HOME)/.gnupg/gpg-agent.conf;
			ln -sfn $(CURDIR)/git/.gitignore $(HOME)/.gitignore;
			ln -sfn $(CURDIR)/git/.gitconfig $(HOME)/.gitignore;
			git update-index --skip-worktree $(CURDIR)/.gitconfig;
			mkdir -p $(HOME)/.config;
			mkdir -p $(HOME)/.local/share;
			mkdir -p $(HOME)/.aws/cli;
			ln -snf $(CURDIR)/.aws/cli/alias $(HOME)/.aws/cli/alias;
			ln -snf $(CURDIR)/.fonts $(HOME)/.local/share/fonts;
			if [ -f /usr/local/bin/pinentry ]; then \
				sudo ln -snf /usr/bin/pinentry /usr/local/bin/pinentry; \
			fi;

.PHONY: test
test: ## Run shellcheck on the scripts
	sh -c ${PREFIX}/test.sh

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'