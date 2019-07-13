#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

# git pull origin master;

function setupZshUbuntu() {
	# install ZSH if needed
	if [ -z $(which zsh) ]; then
		echo "Installing zsh";
		sudo apt install -y zsh;
		sudo chsh -s $(which zsh);
	fi

	# setup Oh-my-ZSH
	if [ ! -d ~/.oh-my-zsh ]; then
		echo "Installing oh-my-zsh";
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	fi
}

function syncSettings() {
	rsync --exclude ".git/" \
		--exclude ".gitconfig" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "symlink-setup.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

setupZshUbuntu;

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	syncSettings;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		syncSettings;
	fi;
fi;

unset setupZsh;
unset syncSettings;
