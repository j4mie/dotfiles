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
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
export PIP_RESPECT_VIRTUALENV=true

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

export JAMIES_BASEPROMPT='\n\e${JAMIES_RED_COLOR}\u \
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

# node
export NODE_PATH=/usr/local/lib/node_modules

# homebrew pythonpath
if [[ "$platform" == 'macosx' ]]; then
    export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
fi
