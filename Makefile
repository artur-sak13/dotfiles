SHELL := bash

.PHONY: all
all: bin dotfiles

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
	for file in $(shell find $(CURDIR) -name ".*" ! -name ".gitignore" ! -name ".gitconfig" ! -name ".github" ! -name ".aws" ! -name ".ci" ! -name ".brew" ! -name ".git" ! -name ".gnupg" ! -path "*vim*"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	gpg --list-keys || true;

	ln -sfn $(CURDIR)/.gnupg/gpg.conf $(HOME)/.gnupg/gpg.conf;
	ln -sfn $(CURDIR)/.gnupg/gpg-agent.conf $(HOME)/.gnupg/gpg-agent.conf;
	ln -sfn $(CURDIR)/git/.gitignore $(HOME)/.gitignore;
	ln -sfn $(CURDIR)/git/.gitconfig $(HOME)/.gitconfig;
	ln -sfn $(CURDIR)/git/.gitconfig.aliases $(HOME)/.gitconfig.aliases;

	mkdir -p $(HOME)/.config/nvim;
	mkdir -p $(HOME)/.local/share;
	mkdir -p $(HOME)/.aws/cli;

	ln -snf $(CURDIR)/.aws/cli/alias $(HOME)/.aws/cli/alias;
	ln -snf $(CURDIR)/zsh/.lambda/lambda-pure.zsh $(HOME)/.oh-my-zsh/custom/themes/lambda-pure.zsh-theme;
	ln -snf $(CURDIR)/vim/.vim $(HOME)/.vim;
	ln -snf $(CURDIR)/vim/.vimrc $(HOME)/.vimrc;
	ln -snf $(HOME)/.vimrc $(HOME)/.config/nvim/init.vim;

	ln -snf $(CURDIR)/starship/starship.toml $(HOME)/.config/starship.toml
	
	sudo ln -snf $(CURDIR)/zsh/.lambda/lambda-pure.zsh /usr/local/share/zsh/site-functions/prompt_lambda-pure_setup;
	sudo ln -snf $(CURDIR)/zsh/.lambda/async.zsh /usr/local/share/zsh/site-functions/async;
	
	if [ -f /usr/local/bin/pinentry ]; then \
		sudo ln -snf /usr/bin/pinentry /usr/local/bin/pinentry; \
	fi;

.PHONY: test
test: ## Run shellcheck on the scripts
	$(SHELL) -c $(CURDIR)/test.sh

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
