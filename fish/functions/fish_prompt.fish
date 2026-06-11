function fish_prompt
    set -l dir (set_color cyan)(prompt_pwd)(set_color normal)
    set -l git (fish_git_prompt)

    echo -n "["(set_color green)"laptop"(set_color normal)" $dir$git] "
    echo -n (set_color green)"λ "(set_color normal)
end