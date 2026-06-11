# source "$HOME/.stuff/functions"
# source "$HOME/.stuff/podman"
# source "$HOME/.stuff/systemd"
# source "$HOME/.stuff/apps"
source "$HOME/.config/fish/modules/systemd/aliases.fish"
source "$HOME/.config/fish/modules/systemd/functions.fish"
source "$HOME/.config/fish/modules/apps.fish"
source "$HOME/.config/fish/modules/sys.fish"
source "$HOME/.config/fish/modules/aliases.fish"

# Git prompt settings
set -g __fish_git_prompt_showdirtystate 1
set -g __fish_git_prompt_showstashstate 1
set -g __fish_git_prompt_showuntrackedfiles 1
set -g __fish_git_prompt_showupstream auto
set -g __fish_git_prompt_show_informative_status 1

# Cleaner symbols
set -g __fish_git_prompt_char_dirtystate '✗'
set -g __fish_git_prompt_char_stagedstate '✓'
set -g __fish_git_prompt_char_stateseparator ' '

fish_config theme choose "dracula"

if pgrep X >/dev/null
    # set -gx PF_INFO "ascii title os kernel wm shell uptime pkgs memory"
    # pfetch
    #nitch
    noorfetch
end