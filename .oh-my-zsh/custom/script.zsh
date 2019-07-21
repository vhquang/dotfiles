function set_zsh_virtualenv() {
    _PYTHON_VIRTUALENV=""

    if [[ ! -z "$VIRTUAL_ENV" ]] && [[ "$(which python)" = *"$(basename $VIRTUAL_ENV)"* ]]; then
    	_PYTHON_VIRTUALENV="%{$fg_bold[blue]%}[$(basename $VIRTUAL_ENV)]%{$reset_color%} "

    elif [[ ! -z "$CONDA_DEFAULT_ENV" ]]; then
        if [[ "$(which python)" = *"$CONDA_DEFAULT_ENV"* ]] || \
                [[ $CONDA_DEFAULT_ENV = 'base' ]]; then
    	    _PYTHON_VIRTUALENV="%{$fg_bold[yellow]%}["$CONDA_DEFAULT_ENV"]%{$reset_color%} "
        fi
    fi

    [[ ! -z $_PYTHON_VIRTUALENV ]] && echo "$_PYTHON_VIRTUALENV";
    unset _PYTHON_VIRTUALENV;
}
