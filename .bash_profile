# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;


################################## COPIED FROM OLD MACHINE ##################################

# Shell prompt based on the Solarized Dark theme.
# Screenshot: http://i.imgur.com/EkEtphC.png
# Heavily inspired by @necolas’s prompt: https://github.com/necolas/dotfiles
# iTerm → Profiles → Text → use 13pt Monaco with 1.1 vertical spacing.

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM='xterm-256color';
fi;


if tput setaf 1 &> /dev/null; then
    tput sgr0; # reset colors
    bold=$(tput bold);
    reset=$(tput sgr0);
    # Solarized colors, taken from http://git.io/solarized-colors.
    black=$(tput setaf 0);
    blue=$(tput setaf 33);
    cyan=$(tput setaf 37);
    green=$(tput setaf 64);
    orange=$(tput setaf 166);
    purple=$(tput setaf 125);
    red=$(tput setaf 124);
    violet=$(tput setaf 61);
    white=$(tput setaf 15);
    yellow=$(tput setaf 136);
else
    bold='';
    reset="\e[0m";
    black="\e[1;30m";
    blue="\e[1;34m";
    cyan="\e[1;36m";
    green="\e[1;32m";
    orange="\e[1;33m";
    purple="\e[1;35m";
    red="\e[1;31m";
    violet="\e[1;35m";
    white="\e[1;37m";
    yellow="\e[1;33m";
fi;

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
    userStyle="${red}";
else
    userStyle="${orange}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
    hostStyle="${bold}${red}";
else
    hostStyle="${yellow}";
fi;

# # Set the terminal title to the current working directory.
# PS1="\[\033]0;\w\007\]";
# PS1+="\[${bold}\]\n"; # newline
# PS1+="\[${userStyle}\]\u"; # username
# PS1+="\[${white}\] at ";
# PS1+="\[${hostStyle}\]\h"; # host
# PS1+="\[${white}\] in ";
# PS1+="\[${green}\]\w"; # working directory
# PS1+="\$(prompt_git \"${white} on ${violet}\")"; # Git repository details
# PS1+="\n";
# PS1+="\[\e[0;90m\]\$(date +%H:%M:%S) "
# PS1+="\[${bold}\]\[${white}\]\$ \[${reset}\]"; # `$` (and reset color)
# export PS1;

# PS2="\[${yellow}\]→ \[${reset}\]";
# export PS2;

# # syntax highlighting with LESS
# export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
# export LESS=' -R '

# # set color for ls in terminal
# export CLICOLOR=1
# export LSCOLORS=GxFxCxDxBxegedabagaced

# -------------------- Replaced by .bin_path --------------------

# # set path for Go
# export GOPATH=$HOME/Dropbox/Codes/gocode
# export PATH=$PATH:$GOPATH/bin

# # set path for Android adb
# export PATH=$PATH:$HOME/Documents/android-sdk-macosx/platform-tools
# export PATH=$PATH:$HOME/Documents/android-sdk-macosx/tools

# # build system for arrow
# export ARROW_BUILD_TYPE=release

# ## arrow's env for pip
# # export ARROW_HOME=$HOME/code/arrow-dist
# # export PARQUET_HOME=$HOME/code/arrow-dist
# # export LD_LIBRARY_PATH=$HOME/code/arrow-dist/lib:$LD_LIBRARY_PATH

# ## arrow's env for conda
# export ARROW_BUILD_TOOLCHAIN=$CONDA_PREFIX
# export PARQUET_BUILD_TOOLCHAIN=$CONDA_PREFIX
# export ARROW_HOME=$CONDA_PREFIX
# export PARQUET_HOME=$CONDA_PREFIX

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# # setup python environment
# source /usr/local/bin//virtualenvwrapper.sh
# export PIP_REQUIRE_VIRTUALENV=true
# gpip(){
#    # bypass pip requirement for active virtualenv, use for update global package
#    # ex: gpip install --upgrade pip setuptools wheel virtualenv
#    PIP_REQUIRE_VIRTUALENV="" pip "$@"
# }

# # if [[ -d "$HOME/.pyenv" ]]; then
# # 	eval "$(pyenv init -)"
# # fi

# # path for mysql
# PATH="/usr/local/mysql/bin:${PATH}"
# export PATH

# # rabbitMQ
# PATH="/usr/local/sbin:${PATH}"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# # path of openCV
# # export PATH="/usr/local/opt/opencv3/bin:$PATH"

#-------------------------- end bin_path --------------------------


test -e ${HOME}/.iterm2_shell_integration.bash && source ${HOME}/.iterm2_shell_integration.bash

# added by Miniconda3 installer
# export PATH="$HOME/miniconda3/bin:$PATH"

