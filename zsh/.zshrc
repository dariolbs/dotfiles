#          _     
#         | |    
#  _______| |__  
# |_  / __| '_ \ 
#  / /\__ \ | | |
# /___|___/_| |_|

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

# Use vim keys in tab complete menu:
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

# Load all plugins
source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "/usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh" 2>/dev/null
source "/usr/share/zsh/plugins//zsh-history-substring-search/zsh-history-substring-search.zsh" 2>/dev/null
source "/usr/share/zsh/plugins//zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null
source "$HOME/.config/zsh/zsh-autopair/autopair.zsh" 2>/dev/null

# Get fzf config
source "$HOME/.config/zsh/fzf/config.zsh"

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

# Load version control information
autoload -Uz vcs_info
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '(%b)'

## PROMPT CONFIG
setopt prompt_subst
PROMPT='%F{green}%n%f%F{yellow}@%f%F{red}%m %f%F{magenta}%~ %F{green}${vcs_info_msg_0_}
%f%F{green}λ '

# Add a newline before the prompt
precmd() { vcs_info; precmd(){ vcs_info; echo "" }}
alias clear='clear; precmd() { vcs_info; precmd(){ vcs_info; echo "" }}'


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

