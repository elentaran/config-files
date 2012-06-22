setopt prompt_subst

autoload colors
colors

# get git branch
autoload -Uz vcs_info

# -------------------------------
# # define core prompt functions
#
# # set some colors
for COLOR in RED GREEN BLUE YELLOW WHITE BLACK CYAN MAGENTA; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
    eval PR_BG_$COLOR='%{$bg[${(L)COLOR}]%}'
    eval PR_BG_BRIGHT_$COLOR='%{$bg_bold[${(L)COLOR}]%}'
done
PR_RST="%{${reset_color}%}"
PR_RESET="%{%b%s%u$reset_color%}"
PR_BG="%{%(?.$PR_RESET.%S)%}"

# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stangedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
FMT_BRANCH=" ${PR_BRIGHT_BLACK}%b%u%c ${PR_RST}" # e.g. master¹²
FMT_ACTION="(${PR_CYAN}%a${PR_RST}%)"   # e.g. (rebase-i)
FMT_PATH="%R${PR_YELLOW}/%S"              # e.g. ~/repo/subdir

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*:prompt:*' unstagedstr   '?'  
zstyle ':vcs_info:*:prompt:*' stagedstr     '+' 
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}" "${FMT_PATH}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}" "${FMT_PATH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   "" "%~"

function lprompt {
    local brackets=$1
    local color1=$2
    local color2=$3
    local color3=$4
    local color4=$5
    local color5=$6
    local color6=$7
    

    local bracket_open="${color1}${brackets[1]}${PR_BG}"
    local bracket_close="${color1}${brackets[2]}${PR_RESET}"

    local git='$vcs_info_msg_0_'
    #local cwd="${color2}%B%1~%b"
    local userhost="${PR_RESET}${color1}${color2}%n${PR_BG_WHITE}${PR_BRIGHT_BLACK} - ${color3}${color4}%m"
    local cwd="${PR_BG_WHITE}${PR_BRIGHT_BLACK} - ${color5}${color6}%~"

    local vimode='${PR_VIMODE}'
    local vicol='${PR_VICOLOR}'

    PROMPT="${bracket_open}${userhost}${cwd}${bracket_close}
${git}${vicol}${vimode}${PR_RESET} "

}

function rprompt {
    local brackets=$1
    local color1=$2
    local color2=$3

    local bracket_open="${PR_BG}${color1}${brackets[1]}${PR_RESET}"
    local bracket_close="${PR_BG}${color1}${brackets[2]}${PR_RESET}"
#    local colon="${color1}:"
#    local at="${color1}@${PR_RESET}"

#    local user_host="${color2}%n${at}${color2}%m"
#    local vcs_cwd='${${vcs_info_msg_1_%%.}/$HOME/~}'
#    local cwd="${color2}%B%20<..<${vcs_cwd}%<<%b"
#    local inner="${user_host}${colon}${cwd}"
    local localtime="${PR_BG}${color2}%T${PR_RESET}"

    RPROMPT="${bracket_open}${localtime}${bracket_close}${PR_RESET}"
}

#if [ -n "$debian_chroot" ]; then
#    PROMPT="$bgc%{$fg[yellow]%}%B${debian_chroot}%b ${PROMPT}"
#fi

if [ $UID -eq 0 ]; then
    lprompt '<>' $PR_RED $PR_RED $PR_RED
    rprompt '<>' $PR_RED $PR_RED
else
    case $HOST in
        *)
            lprompt '' $PR_BG_BRIGHT_WHITE $PR_BRIGHT_BLUE $PR_BG_BRIGHT_WHITE $PR_BRIGHT_MAGENTA $PR_BG_BRIGHT_WHITE $PR_BRIGHT_RED
            rprompt '[]' $PR_BRIGHT_BLACK $PR_BRIGHT_BLACK
            ;;
    esac
fi



# ------------------------------
# update the vcs_info_msg_ magic variables, but only as little as possible

PR_GIT_UPDATE=1

# if we do some things on the git
function zsh_git_prompt_preexec {
        case "$(history $HISTCMD)" in 
            *git*)
                PR_GIT_UPDATE=1
                ;;
        esac
}
preexec_functions+='zsh_git_prompt_preexec'

# called after directory change
function zsh_git_prompt_chpwd {
        PR_GIT_UPDATE=1
}
chpwd_functions+='zsh_git_prompt_chpwd'

# Trick otherwise chpwd_functions
chpwd_functions=(${chpwd_functions[@]})

# called before prompt generation
function zsh_git_prompt_precmd {
       if [[ -n "$PR_GIT_UPDATE" ]] ; then
               vcs_info 'prompt'
               PR_GIT_UPDATE=
       fi
}
precmd_functions+='zsh_git_prompt_precmd'

# ------------------------------
# handle vi NORMAL/INSERT mode change
PR_VIMODE="#"
PR_VICOLOR=${PR_BLUE}
function zle-line-init zle-keymap-select {
        PR_VIMODE="${${KEYMAP/vicmd/¢}/(main|viins)/$}"
        PR_VICOLOR="${${KEYMAP/vicmd/${PR_RED}}/(main|viins)/${PR_GREEN}}"
        zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# ------------------------------
# this stuff updates screen and xterm titles as the command runs

case $TERM in
    xterm* | rxvt* | urxvt*)
        function zsh_term_prompt_precmd {
                print -Pn "\e]0;%n@%m: %~\a"
        }
        function zsh_term_prompt_preexec {
                local x="${${${1//\"/\\\"}//\$/\\\\\$}//\%/%%}"
                print -Pn "\e]0;%n@%m: %~  $x\a"
        }
        preexec_functions+='zsh_term_prompt_preexec'
        precmd_functions+='zsh_term_prompt_precmd'
        ;;
screen*)
        function zsh_term_prompt_precmd {
                print -nR $'\033k'"zsh"$'\033'\\\

                print -nR $'\033]0;'"zsh"$'\a'
        }
        function zsh_term_prompt_preexec {
                local x="${${${1//\"/\\\"}//\$/\\\\\$}//\%/%%}"
                print -nR $'\033k'"$x"$'\033'\\\

                print -nR $'\033]0;'"$x"$'\a'
        }
        preexec_functions+='zsh_term_prompt_preexec'
        precmd_functions+='zsh_term_prompt_precmd'
        ;;
esac

