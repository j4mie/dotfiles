# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Check what platform we're on
# https://github.com/baalexander/bash/blob/master/.bashrc
platform='linux'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='macosx'
fi


# Pip and virtualenv
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
    export PIP_RESPECT_VIRTUALENV=true
fi

# Set up custom prompt.
# quite a lot borrowed from http://github.com/mitsuhiko/dotfiles/blob/master/bash/bashrc

export GIT_PS1_SHOWDIRTYSTATE=1

JAMIES_DEFAULT_COLOR="[00m"
JAMIES_CYAN_COLOR="[36m"
JAMIES_PINK_COLOR="[35m"
JAMIES_GREEN_COLOR="[32m"
JAMIES_ORANGE_COLOR="[33m"
JAMIES_RED_COLOR="[31m"

function __pwd () {
    WORKING_DIR="$( pwd )"
    PARENT_DIR="$( dirname "${WORKING_DIR}" )"

    if [ "${WORKING_DIR}" = '/' ]; then
        echo '/'
    else
        if [ "${PARENT_DIR}" = '/' ]; then
            echo $( basename "${WORKING_DIR}" )
        else
            echo $( basename "${PARENT_DIR}" )/$( basename "${WORKING_DIR}" )
        fi
    fi
}

function __ssh () {
    if [ -n "$SSH_CLIENT" ]; then
        echo '*** '
    fi
}

export JAMIES_BASEPROMPT='\n\e${JAMIES_RED_COLOR}`__ssh`\u \
\e${JAMIES_CYAN_COLOR}at \e${JAMIES_ORANGE_COLOR}\h \
\e${JAMIES_CYAN_COLOR}in \e${JAMIES_GREEN_COLOR}`__pwd`\
$(__git_ps1 " \e${JAMIES_CYAN_COLOR}on \e${JAMIES_PINK_COLOR}git:%s")\e${JAMIES_DEFAULT_COLOR}'

export PS1="${JAMIES_BASEPROMPT}
$ "

# Make "ls" output coloured
export CLICOLOR=1

# add ~/bin directory to PATH
PATH=~/bin:$PATH
export PATH

# Set up bash completion, if it's been installed with homebrew
if which brew &> /dev/null; then
    if [ -f `brew --prefix`/etc/bash_completion ]; then
       . `brew --prefix`/etc/bash_completion
    fi
fi

# bash completion for linux, must be installed
# with sudo apt-get install bash-completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# set up python interpreter stuff
if [ -f ~/.pythonrc ]; then
    export PYTHONSTARTUP=~/.pythonrc
fi

# don't write .pyc and .pyo files
# removed for now. seems to break pip.
# export PYTHONDONTWRITEBYTECODE=1

# unbreak xcode gcc
if [[ "$platform" == 'macosx' ]]; then
    export ARCHFLAGS="-arch x86_64"
fi

export PATH=/usr/local/bin:/usr/local/sbin:/Developer/usr/bin:$PATH

# node & npm
export PATH=/usr/local/share/npm/bin:$PATH

function sssh() {
    ssh -t $@ dtach -A /tmp/dtach bash
}

[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc

export NVM_DIR="/Users/jamie/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
