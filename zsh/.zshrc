# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Zshell configuration
# 
# Configured by Dário Batista
#
# Plugins used:
#
# zsh-history-substring-search: https://github.com/zsh-users/zsh-history-substring-search
# zsh-autopair: https://github.com/hlissner/zsh-autopair
# zsh-autosuggestions: https://github.com/zsh-users/zsh-autosuggestions
# zsh-syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting
#
# Prompts:
#
# powerlevel10k: https://github.com/romkatv/powerlevel10k
# starship: https://starship.rs/

# Zsh history file
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# P10k instant prompt
# Execute an alert script if it exists
if [ -f "$HOME/.alert" ]; then 
    eval "$HOME/.alert";
else
    source "$HOME/.config/zsh/powerlevel10k/config/personal/instant_prompt.zsh"
fi

# Load environment variables
source "$HOME/.config/zsh/init/environment.zsh"

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Load all plugins
source "$HOME/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh" 2>/dev/null
source "$HOME/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh" 2>/dev/null
source "$HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null
source "$HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2>/dev/null
source "$HOME/.config/zsh/zsh-autopair/autopair.zsh" 2>/dev/null

# Load profile
source "$HOME/.profile"

if [ -f "$HOME/Documents/profile" ]; then
    source "$HOME/Documents/profile"
fi

# Get fzf config
source "$HOME/.config/zsh/fzf/config.zsh"

# Load keybindings
source "$HOME/.config/zsh/keybindings/tmux.zsh"

# Startup on tty1
source "$HOME/.config/zsh/init/tty1.zsh"

# Load main zsh config
source "$HOME/.config/zsh/init/config.zsh"

# Get prompt functions
source "$HOME/.config/zsh/init/prompts.zsh"

# Decide what prompt to use
# Options: "p10k" "starship" "default" "pure"
SEL_PROMPT="p10k"
eval "apply_${SEL_PROMPT}"

# Custom start folder
rootfile="$HOME/.rootdir"
test -f $rootfile || touch $rootfile

setroot() {
    dir=""
    if [ -n "$1" ]; then
        dir="$(realpath $1)"
        test ! -d "$dir" && echo "$dir is not a diretiry" && return 1
        test ! -r "$dir" && echo "No read access to $dir" && return 1
    fi
    echo $dir > $rootfile
}

export START_FOLDER="$(< $rootfile 2> /dev/null)"

if [ -n "$START_FOLDER" ]; then
    cd "$START_FOLDER"
fi

# script that executes automatically once you enter tty1
export TTY1_SCRIPT="$HOME/.tty1.sh"
