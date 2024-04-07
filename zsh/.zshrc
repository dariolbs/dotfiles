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
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}

zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

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
# LF ICONS
[ -f ~/.config/lf/LF_ICONS ] && {
	LF_ICONS="$(tr '\n' ':' <~/.config/lf/LF_ICONS)" \
		&& export LF_ICONS
    [ -f "$HOME/.config/lf/LF_COLORS" ] && source "$HOME/.config/lf/LF_COLORS"
}

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
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '(%b)'

## PROMPT CONFIG
lcrv() {
    rv=$?
    if [ $rv -gt 0 ]; then
        echo "$rv "
    fi
}
setopt prompt_subst
PROMPT='%F{green}%n%f%F{yellow}@%f%F{red}%m %B%f%F{magenta}%~%b %F{green}${vcs_info_msg_0_}
%B%F{red}$(lcrv)%f%F{blue}λ%b%f '

# Add a newline before the prompt
precmd() { vcs_info; precmd(){ vcs_info; echo "" }}
alias clear='clear; precmd() { vcs_info; precmd(){ vcs_info; echo "" }}'

## Who needs a plugin manager?

declare -A plugin_repos

# Plugins are stored to $HOME/.local/share/zsh
ZSH_PLUGIN_DIR="$HOME/.local/share/zsh/"
mkdir -p "$ZSH_PLUGIN_DIR"

plugin_repos=(
    ["zsh-syntax-highlighting"]='https://github.com/zsh-users/zsh-syntax-highlighting.git'
    ["zsh-history-substring-search"]='https://github.com/zsh-users/zsh-history-substring-search'
    ["zsh-autosuggestions"]='https://github.com/zsh-users/zsh-autosuggestions'
    ["zsh-autopair"]='https://github.com/hlissner/zsh-autopair'
    )

plugin-sync() {
    cdir="$PWD"
    cd $ZSH_PLUGIN_DIR
    for plugin in "${(k)plugin_repos[@]}"; do
        pdir="$ZSH_PLUGIN_DIR/$plugin"
        if [ ! -d "$pdir" ]; then
            cd "$pdir"
            echo "Plugin $plugin is not installed, cloning ${plugin_repos[$plugin]}..."
            git clone "${plugin_repos[$plugin]}"
            cd ..
        else
            cd "$pdir"
            echo "Updating $plugin..."
            git pull
            cd ..
        fi
    done
    cd $cdir
}

plugin-source() {
    cdir="$PWD"
    cd $ZSH_PLUGIN_DIR
    for plugin in ${(k)plugin_repos[@]}; do
        pdir="$ZSH_PLUGIN_DIR/$plugin"
        [ -d "$pdir" ] && source "$pdir/$plugin.plugin.zsh"
    done
    cd $cdir
}

# You can change the default starting folder
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

## AUTOMATIC STARTUP
export TTY1_SCRIPT="$HOME/.tty1.sh"

if [[ "$(tty)" == "/dev/tty1" ]]; then

    if [[ ! -f "$TTY1_SCRIPT" ]]; then
        printf "#!/usr/bin/sh\nstartx\n" > "$TTY1_SCRIPT"
        chmod +x $TTY1_SCRIPT
        echo "Generated default startup script at $TTY1_SCRIPT"
        echo "Change it to your needs!"
        sleep 1
    fi

    echo "Executing $TTY1_SCRIPT..."
    exec "$TTY1_SCRIPT"
fi

# Source all plugins
plugin-source
