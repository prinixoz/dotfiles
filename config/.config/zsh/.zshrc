autoload -Uz compinit # Initializing suggestions
zstyle ':completion:*' menu select # For arrow selecting a suggestion
zstyle ':completion:*' rehash true
export ZDOTDIR=$HOME/.config/zsh # Define zsh directory
stty stop undef	# Disable ctrl-s to freeze terminal.

compinit -d /home/user/.local/share/zsh/.zcompdunmp
ZSHPROFILEPATH="/home/user"
# History 
HISTFILE=$ZSHPROFILEPATH/.local/share/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

source $ZSHPROFILEPATH/.config/shell/alias
source $ZSHPROFILEPATH/.config/shell/export

#PLUGINS
source $ZSHPROFILEPATH/.config/zsh/plugins/autopair
source $ZSHPROFILEPATH/.config/zsh/plugins/autosudo
source $ZSHPROFILEPATH/.config/zsh/plugins/prompt
source $ZSHPROFILEPATH/.config/zsh/plugins/keybindings

function copypath (){
  local file="${1:-.}"
  [[ $file = /* ]] || file="$PWD/$file"
  print -n "${file:a}" | xclip -sel clip || return 1
  echo ${(%):-"%B${file:a}%b copied to clipboard."}
}

#eval "$(starship init zsh)"
