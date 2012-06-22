# compinit initializes the completion
autoload -U compinit
compinit

# zrecompile precompile zsh code to make it faster
autoload -U zrecompile

# suggest a package to install when the command is not found
if [ -f /etc/zsh_command_not_found ]; then
    source /etc/zsh_command_not_found
fi

# source the files in the directory .zsh.d 
for zshrc_snipplet in ~/.zsh.d/[0-9][0-9]*[^~] ; do
    source $zshrc_snipplet
done

# handle completion for R after "-"
compdef _gnu_generic R


