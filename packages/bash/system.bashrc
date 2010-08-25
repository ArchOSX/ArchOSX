#
# /opt/arch/etc/bash.bashrc
#
# This file is the systemwide bashrc file. While most of the
# environment is preserved when running an interactive shell
# the PS[1-4] variables, aliases and functions are reset.
#
# When running a non-login shell, apply the following settings:
# - Prompt defaults (PS[1-4], PROMPT_COMMAND)
# - bash_completion if it exists
# - source /opt/arch/etc/bash.bashrc.local

PS1='[\u@\h \W]\$ '
PS2='> '
PS3='> '
PS4='+ '

export PS1 PS2 PS3 PS4

if test "$TERM" = "xterm" -o \
        "$TERM" = "xterm-color" -o \
        "$TERM" = "xterm-256color" -o \
        "$TERM" = "rxvt" -o \
        "$TERM" = "rxvt-unicode" -o \
        "$TERM" = "xterm-xfree86"; then
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
    export PROMPT_COMMAND
fi

[ -r /opt/arch/etc/bash_completion   ] && . /opt/arch/etc/bash_completion
[ -r /opt/arch/etc/bash.bashrc.local ] && . /opt/arch/etc/bash.bashrc.local
