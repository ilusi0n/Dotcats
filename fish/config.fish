# source "$HOME/.stuff/functions"
# source "$HOME/.stuff/podman"
# source "$HOME/.stuff/systemd"
# source "$HOME/.stuff/apps"
source "$HOME/.config/fish/modules/systemd/aliases.fish"
source "$HOME/.config/fish/modules/systemd/functions.fish"
source "$HOME/.config/fish/modules/apps.fish"
source "$HOME/.config/fish/modules/sys.fish"
source "$HOME/.config/fish/modules/aliases.fish"

if pgrep X >/dev/null
    # set -gx PF_INFO "ascii title os kernel wm shell uptime pkgs memory"
    # pfetch
    nitch
end