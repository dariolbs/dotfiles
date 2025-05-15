#          _     
#         | |    
#  _______| |__  
# |_  / __| '_ \ 
#  / /\__ \ | | |
# /___|___/_| |_|
#
# "É isso aí mesmo mano"

## ZSH CONFIG
# Basic auto/tab complete:
autoload -U compinit; compinit
zstyle ':completion:*' menu select

zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
        [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins        # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}

zle -N zle-line-init
echo -ne '\e[5 q'       # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;}    # Use beam shape cursor for each new prompt.

# Zsh history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

## ENVIRONMENT VARIABLES
export EDITOR="nvim"
export MANPAGER="nvim +Man!"

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Load profile
source "$HOME/.profile"

# Get fzf config
source "$HOME/.config/zsh/fzf/config.zsh"
source "$HOME/.config/zsh/plugin_manager"

# Put your plugins here
# Keys = git repo
# Vals = path for the plugin file
#
plugins=(
    'zsh-users/zsh-syntax-highlighting'
    'zsh-users/zsh-history-substring-search'
    'zsh-users/zsh-autosuggestions'
    'hlissner/zsh-autopair'
    )

# You can change the default starting folder
rootfile="$HOME/.rootdir"
test -f $rootfile || touch $rootfile

setroot() {
    dir=""
    if [ -n "$1" ]; then
        dir="$(realpath $1)"
        test ! -d "$dir" && echo "$dir is not a directory" && return 1
        test ! -r "$dir" && echo "No read access to $dir" && return 1
    fi
    echo $dir > $rootfile
}

export START_FOLDER="$(< $rootfile 2> /dev/null)"

if [ -n "$START_FOLDER" ]; then
    cd "$START_FOLDER"
fi

source "$HOME/.config/zsh/login_manager"

## YAZI

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias lf="yy"
