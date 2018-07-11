# .bashrc

# adress server 192.168.33.40

# User specific aliases and functions
alias emacs='emacs -nw'
# alias weka='java -Xmx2048m -classpath $CLASSPATH:/home/arimmel/Tools/weka-3-7-4/weka.jar weka.gui.GUIChooser'
#alias weka='java -jar /home/arimmel/Tools/weka-3-7-4/weka.jar'

alias ls='ls --color=auto'
alias ll='ls -al'
alias grep='grep --color=auto'
alias less='less -X'
alias gdvim='google docs edit --editor vim --title'

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
