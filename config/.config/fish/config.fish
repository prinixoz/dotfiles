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


# Vi mode
set -g fish_key_bindings fish_vi_key_bindings

# Block cursor in insert mode
set -g fish_cursor_insert block

# Block cursor in normal mode
set -g fish_cursor_default block

# Block cursor in visual mode
set -g fish_cursor_visual block


alias so="source ~/.config/fish/config.fish"

starship init fish | source
