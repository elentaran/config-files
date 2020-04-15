# .bashrc

# User specific aliases and functions

# for linux
#alias ls='ls --color=auto'
#alias ll='ls -l'
# for macOS
alias ls='ls -G'
alias ll='ls -l'

alias grep='grep --color=auto'
alias less='less -X'

alias python='python3'
alias pip='pip3'

export EDITOR=vim

#black background
#PS1="\[\e[32;40m\][\t] \[\e[31;40m\]\u@\h:\[\e[36;40m\]\w \[\e[37;40m\]\$ "

#white background
PS1="\[\e[0;31m\][\t] \[\e[0;32m\]\u@\h:\[\e[0;34m\]\w \[\e[1;30m\]\$ "


PATH=/bin:$PATH
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:.local/bin
