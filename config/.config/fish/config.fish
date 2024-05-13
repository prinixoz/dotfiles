set fish_greeting ""
set -x EDITOR nvim

source ~/.config/shell/alias
source ~/.config/shell/export

function stowgit
    read -p 'echo "Type your commit message here : "' commitmsg
    cd /home/prinix/project/prinixoz/dotfiles/
    stow -vt ~ dotfiles && git add .
    git commit -m $commitmsg
    git push -u origin main && cd -
end

function push
    read -p 'echo "Type your commit message here : "' commitmsg
    git add .
    git commit -m $commitmsg
    git push -u origin main
end

function bak --argument filename
    cp $filename $filename.bak
end

alias so="source ~/.config/fish/config.fish"

export LC_CTYPE="en_GB.utf8"
starship init fish | source
