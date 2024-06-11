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

# Execute an alert script if it exists
if [ -f "$HOME/.alert" ]; then 
    eval "$HOME/.alert";
fi

## ENVIRONMENT VARIABLES
export EDITOR="nvim"

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Load profile
source "$HOME/.profile"

# Load persona profile
if [ -f "$HOME/Documents/profile" ]; then
    source "$HOME/Documents/profile"
fi

# Get fzf config
source "$HOME/.config/zsh/fzf/config.zsh"

# Load version control information
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
# Format the vcs_info_msg_0_ variable
# zstyle ':vcs_info:git:*' formats '%s %b %m%u%c'
zstyle ':vcs_info:git*' actionformats "%s  %r/%S %b %m%u%c "

## PROMPT CONFIG
lcrv() {
    rv=$?
    if [ $rv -gt 0 ]; then
        echo "%F{red}$rv%f "
    fi
}

setopt prompt_subst

# Old prompt
if [[ "$(tty)" == "/dev/tty"* ]]; then
    PROMPT='%B%F{green}%n%f%F{yellow}@%f%F{red}%m %B%f%F{magenta}%~%b %F{green}${vcs_info_msg_0_}
%B%F{red}$(lcrv)%f%F{blue}%b$%f '
else
    PROMPT='%F{red}%u%F{magenta}%~ %b%F{green}${vcs_info_msg_0_}
%B%F{red}$(lcrv)%f%F{blue}λ%b%f '
    RPROMPT="%F{black}%n%f%F{black}@%f%F{black}%m%f"
fi

# Add a newline before the prompt
precmd() { vcs_info; precmd(){ vcs_info; echo "" }}
alias clear='clear; precmd() { vcs_info; precmd(){ vcs_info; echo "" }}'

source "$HOME/.config/zsh/plugin_manager"

# Put your plugins here
# Keys = git repo
# Vals = path for the plugin file
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

## AUTOMATIC STARTUP
export TTY1_SCRIPT="$HOME/.tty1.sh"

if [[ "$(tty)" == "/dev/tty1" ]]; then

    if [[ ! -f "$TTY1_SCRIPT" ]]; then
        printf "#!/usr/bin/sh\nstartx\n" > "$TTY1_SCRIPT"
        echo "Generated default startup script at $TTY1_SCRIPT"
        echo "Change it to your needs!"
        sleep 1
    fi

    if [ ! -x $TTY1_SCRIPT ]; then
        chmod +x $TTY1_SCRIPT
    fi

    echo "Executing $TTY1_SCRIPT..."
    exec "$TTY1_SCRIPT"
fi

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

# Launch yazy imediately
if [ -f /tmp/yazi-launcher ]; then
    rm -f /tmp/yazi-launcher
    yy
fi

plugin-load
