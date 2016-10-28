# Author: fcrh
# Email: coquelicot1117@gmail.com
# Last Modified: 2016/10/28

# settings {{{
# emacs style, not vi
set +o vi
set -o emacs

## get rid of annoying features
shopt -u cdable_vars
shopt -u cdspell
shopt -u huponexit
shopt -u sourcepath
shopt -u nocasematch
shopt -u execfail
set +o allexport
set +o ignoreeof
set +o noclobber

# useful features
shopt -s checkhash
shopt -s checkwinsize
shopt -s progcomp
shopt -s promptvars
shopt -s expand_aliases
set -o braceexpand
set -o histexpand
set -o pipefail
set -o monitor

# path matching
shopt -s dotglob
shopt -s nocaseglob
shopt -u failglob # fix bash-completion
shopt -u nullglob # fix bash-completion

# handle multi-line cmd history
shopt -s cmdhist
shopt -s lithist

# misc
shopt -s mailwarn
shopt -s gnu_errfmt
shopt -s no_empty_cmd_completion
# }}}


# variables

export EDITOR="vim"


# alias

alias ll="ls -hFlG"
alias la="ls -hFlAG"

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"


# handy version of popd/pushd

function pd {
    if [[ $# -eq 0 ]]; then
        popd >/dev/null 2>/dev/null;
    elif [[ $# -eq 1 && $1 = "-" ]]; then
        pushd >/dev/null 2>/dev/null;
    else
        pushd $@ >/dev/null;
    fi
}


# prompt

export PROMPT_COMMAND=__generate_prompt

PTCLR_HOST="31m"
PTCLR_USER="35m"
PTCLR_PATH="36m"
PTCLR_FAIL="1;31m"
PTCLR_GIT="33m"

__generate_prompt() {

    local ret_code=$?
    local git_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

    PS1="\[\e[${PTCLR_HOST}\]\h \[\e[${PTCLR_USER}\]\u \[\e[${PTCLR_PATH}\]{ \w }"

    if [[ $git_branch != "" ]]; then
        PS1+=" \[\e[${PTCLR_GIT}\]${git_branch}";
    fi
    if [[ $ret_code -ne 0 ]]; then
        PS1+=" \[\e[${PTCLR_FAIL}\](${ret_code})";
    fi

    PS1+="\[\e[m\] \\$ "

}

