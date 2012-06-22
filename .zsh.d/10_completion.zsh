
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                             /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'
zstyle ':completion:*' max-errors 0 numeric
zstyle ':completion:*' use-compctl false

#   (from http://www.grml.org/zsh/zsh-lovers.html)

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh.cache
# Prevent CVS files/directories from being completed :
# zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
# zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'
# Fuzzy matching of completions for when you mistype them:
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
# And if you want the number of errors allowed by _approximate to
# increase with the length of what you have typed so far:
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
# Ignore completion functions for commands you don’t have:
zstyle ':completion:*:functions' ignored-patterns '_*'
# With helper functions like:
xdvi() { command xdvi ${*:-*.dvi(om[1])} }
# you can avoid having to complete at all in many cases, but if you do,
# you might want to fall into menu selection immediately and to have the
# words sorted by time:
zstyle ':completion:*:*:xdvi:*' menu yes select
zstyle ':completion:*:*:xdvi:*' file-sort time
# Completing process IDs with menu selection:
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
# If you end up using a directory as argument, this will remove the
# trailing slash (usefull in ln)
zstyle ':completion:*' squeeze-slashes true
# cd will never select the parent directory (e.g.: cd ../<TAB>):
zstyle ':completion:*:cd:*' ignore-parents parent pwd


# completion:<func>:<completer>:<command>:<argument>:<tag>
[ -f ~/.ssh/config ] && :\
    ${(A)ssh_config_hosts:=${${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*\**}:#*\?*}}

[ -f ~/.ssh/known_hosts ] && :\
    ${(A)ssh_known_hosts:=${${${(f)"$(<$HOME/.ssh/known_hosts)"}%%\ *}%%,*}}

zstyle ':completion:*:*:*' hosts $ssh_config_hosts $ssh_known_hosts

# When completing process IDs I normally want to fall into menu
# selection, too:, but I also want to make sure that I always get the
# list, even if I complete on a command name prefix instead of a PID
# and there is only one possible completion, which is inserted right
# away. This means that the completion system shows me the excerpt
# from the `ps(1)' output for verification that the inserted PID is
# indeed the one of the command I want to kill

zstyle ':completion:*:*:*:*:*' menu yes select
#zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always

## on processes completion complete all user processes
zstyle ':completion:*:processes' command 'ps -U$USER'

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'%{\e[0;33m%}%d%{\e[0m%}'
zstyle ':completion:*:messages' format $'%{\e[0;33m%}%d%{\e[0m%}'
zstyle ':completion:*:warnings' format\
    $'%{\e[0;33m%}No matches for: %d%{\e[0m%}'
zstyle ':completion:*:corrections' format\
    $'%{\e[0;33m%}%d (errors: %e)%{\e[0m%}'


