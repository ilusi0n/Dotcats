function fish_prompt
    set -l dir (set_color cyan)(prompt_pwd)(set_color normal)
    set -l git (fish_git_prompt)

    echo -n "[$dir$git] " (set_color green)"λ "(set_color normal)
end

if set -q SSH_TTY
  set -g fish_color_host brred
end