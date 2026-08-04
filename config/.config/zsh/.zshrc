export ZDOTDIR=$HOME/.config/zsh 
ZSHPROFILEPATH="/home/user/.config/zsh"

# History 
HISTFILE=$ZSHPROFILEPATH/.local/share/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space

source $ZSHPROFILEPATH/plugins/autopair
source $ZSHPROFILEPATH/plugins/autosudo
source $ZSHPROFILEPATH/plugins/prompt
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

eval "$(starship init zsh)"
