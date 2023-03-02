# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Basic auto/tab complete:
autoload -U compinit
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

#Defaults
export EDITOR="vim"
# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Load all plugins
source $HOME/.config/zsh/zsh-history-substring-search.plugin.zsh 2>/dev/null
source $HOME/.config/zsh/zsh-autosuggestions.zsh 2>/dev/null
source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

#LF
[ -f ~/.config/lf/LF_ICONS ] && {
	LF_ICONS="$(tr '\n' ':' <~/.config/lf/LF_ICONS)" \
		&& export LF_ICONS
}

#APPLY TTY SCHEME
apply_tty_scheme() {
	if [[ "$(tty)" == "/dev/tty"* ]]; then
        neofetch
        #PROMPT="%B%F{green}%n%f%b%B%F{yellow}@%f%b%B%F{blue}%m%f%b %B%F{magenta}%~%f%b %B%F{green}>%f%b "
        PROMPT="%B%F{red}[%F{green}%n%f%b%B%F{yellow}@%f%b%B%F{blue}%m%f%b%F%B%F{magenta} %~%f%b %B%F{red}]%B%F{green} $%f%b "
    else
        source $HOME/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme &>/dev/null
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
	fi
	return 0
}
export PATH="$HOME/.local/bin/:${PATH}:$HOME/.scripts/bin/:$HOME/.scripts/handy:$HOME/.scripts/startup:$JAVA_HOME"
apply_tty_scheme
