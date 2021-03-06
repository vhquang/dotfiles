# uncomment to profile prompt startup with zprof
# zmodload zsh/zprof

# history
SAVEHIST=100000


# export PURE_GIT_UNTRACKED_DIRTY=0


# zle -N zle-line-init


# history mgmt
# http://www.refining-linux.org/archives/49/ZSH-Gem-15-Shared-history/
setopt inc_append_history
setopt share_history


zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# uncomment to finish profiling
# zprof


# Load default dotfiles
# source ~/.bash_profile


if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM='xterm-256color';
fi;


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="random"


# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
	dotenv
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

optional_source_files=(
    .env
    .bin_path
    .custom_bin_path
    .functions
    .aliases
)
for i in "${optional_source_files[@]}"; do
    if [ -f "$HOME/$i" ]; then
        source "$HOME/$i";
    fi
done
unset optional_source_files


VIRTUAL_ENV_DISABLE_PROMPT=1
# may also need to hide conda prompt
# conda config --set changeps1 False

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

display_duration() {
    local x=$1
    local st=''
    local token=( s m h )
    for t in "${token[@]}"; do
        st=$(( x % 60 ))$t$st
        x=$(( x / 60 ))
        if [ "$x" -eq 0 ]; then
            break
        fi
    done
    echo $st
}

# Displays the exec time of the last command if set threshold was exceeded
# copy from refined.zsh-theme
cmd_exec_time() {
    local stop=`date +%s`
    local start=${__cmd_timestamp:-$stop}
    let local elapsed=$stop-$start
    [ $elapsed -gt 5 ] && echo %{$fg[yellow]%}$(display_duration $elapsed)%{$reset_color%}
}

# Get the initial timestamp for cmd_exec_time
preexec() {
    __cmd_timestamp=`date +%s`
}

__temp_zsh_prompt="$PROMPT"
PROMPT='
$(set_zsh_virtualenv) $(cmd_exec_time)
'"$(trim_lead_line $__temp_zsh_prompt)"
unset __temp_zsh_prompt;

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# tell brew not to use git credential for public repo
export HOMEBREW_NO_GITHUB_API=1

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

conda activate ml

function sync-rl() {
    rsync \
        --exclude ".git/" \
        --exclude "*__pycache__*" \
        --exclude "*.pyc" \
        --exclude "*.h5" \
        --exclude "*.vscode" \
        --exclude "observations/" \
        -avh --no-perms ~/code/7642-RL/project_2/  vu@is-vu-01:~/code/7642Fall2019qvu9/project_2;
}
