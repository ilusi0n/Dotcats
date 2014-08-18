export EDITOR=vim
#export PATH=$PATH:/home/ilusi0n/.gem/ruby/2.0.0/bin

#= MODULES ====================================================================
autoload -U compinit promptinit colors
compinit
promptinit
colors

zstyle ':completion:*' menu select

#---------#
# Options #
#---------#

setopt hist_ignore_dups     # Don't save duplicate entries in history
setopt share_history        # Share history between shells
setopt interactivecomments  # Enable comments in interactive mode

export HISTFILE=~/.zsh_history
export SAVEHIST=$HISTSIZE


#---------#
# Aliases #
#---------#

source "$HOME/.zsh_stuff/aliases"

#-----------#
# Functions #
#-----------#

source "$HOME/.zsh_stuff/functions"


# colors for ls
if [[ -f ~/.zsh_stuff/dir_colors ]]; then
    eval $(dircolors -b ~/.zsh_stuff/dir_colors)
fi


#---------------#
# Startup stuff #
#---------------#

if [ "$(pgrep X)" ]
then
    $HOME/.scripts/thecat.sh
fi


#--------#
# Prompt #
#--------#

PROMPT='%F{green}%~%F{blue} >>%f '
#RPROMPT='%F{blue}]'
