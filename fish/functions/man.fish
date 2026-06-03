function man
    set -lx LESS_TERMCAP_mb \e'[01;31m'
    set -lx LESS_TERMCAP_md \e'[01;38;5;74m'
    set -lx LESS_TERMCAP_me \e'[0m'
    set -lx LESS_TERMCAP_se \e'[0m'
    set -lx LESS_TERMCAP_so \e'[38;5;246m'
    set -lx LESS_TERMCAP_ue \e'[0m'
    set -lx LESS_TERMCAP_us \e'[04;38;5;146m'

    command man $argv
end