set fish_greeting ""
set -x EDITOR nvim

source ~/.config/shell/alias
source ~/.config/shell/export

source ~/.config/fish/zoxie.conf


function fish_prompt
    set_color --bold white
    echo -n "["

    set_color blue
    echo -n (whoami)

    set_color blue
    echo -n "@"

    set_color red
    echo -n $hostname

    set_color white
    echo -n " "

    set_color green
    echo -n (prompt_pwd)

    set_color white
    echo -n "]\$ "

    set_color normal
end

function fish_mode_prompt
    # do nothing (removes [I], [N], etc.) remove prompt for neovim
end




alias so="source ~/.config/fish/config.fish"

starship init fish | source
