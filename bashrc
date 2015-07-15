#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#---------#
# Aliases #
#---------#

source "$HOME/.stuff/aliases"

#-----------#
# Functions #
#-----------#

source "$HOME/.stuff/functions"


# colors for ls
if [[ -f ~/.zsh_stuff/dir_colors ]]; then
    eval $(dircolors -b ~/.zsh_stuff/dir_colors)
fi

# bash completion
#set show-all-if-ambiguous on

# --- history
# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
unset HISTFILESIZE
HISTCONTROL=ignoreboth:erasedups
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=3000
#HISTFILESIZE=


#---------------#
# Startup stuff #
#---------------#

#if [ "$(pgrep X)" ]
#then
#  $HOME/.scripts/thecat.sh
#fi

export GITAWAREPROMPT=~/.scripts/git-aware-prompt
source $GITAWAREPROMPT/main.sh


#export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
PS1="\n\[\033[0;32m\]\u@\h \[\033[1;33m\]\w\n\[\033[0;34m\]>>\[\033[0m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\] "
PS2='\\ '
