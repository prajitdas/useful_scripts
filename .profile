# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# ls colors using default database
eval "$(dircolors)"
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# P4 QOL improvements
## P4 colored diffs
export P4DIFF='/usr/bin/diff --color'
export EDITOR='/usr/bin/vim'
alias build='./wrims.sh "make -j50 clean distclean && make build"'

# Gentoo PS1, modified to make it look like the Ubuntu PS1
PS1='\[\033]0;\u@\h:\w\007\]\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Better PS1
PROMPT_COMMAND=__prompt_command
__prompt_command() {
    local EXIT="$?"                # This needs to be first
    PS1='\[\033]0;\u@\h:\w\007\]'

    local RCol='\[\e[0m\]'

    local Red='\[\e[0;31m\]'
    local Gre='\[\e[01;32m\]'
    local Yel='\[\e[0;33m\]'
    local Blu='\[\e[0;34m\]'
    local Pur='\[\e[0;35m\]'

    if [ $EXIT != 0 ]; then
        PS1+="${Red}\u@\h${RCol}"        # Add red if exit code non 0
    else
        PS1+="${Gre}\u${Yel}@${Gre}\h${RCol}"
    fi

    PS1+="${Yel}:${Blu}\w${Yel}$ ${RCol}"
}

# Set myself reminders
if [ -e ~/.remindme ]
then
	echo -e '\e[0;31m'
	cat ~/.remindme
	echo -e '\e[0m'
fi

export DOCKER_OPTS+=" --insecure-registry dockerhub.cisco.com"
