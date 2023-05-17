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
export EDITOR="nvim"
# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Load all plugins
source $HOME/.config/zsh/zsh-history-substring-search.plugin.zsh 2>/dev/null
source $HOME/.config/zsh/zsh-autosuggestions.zsh 2>/dev/null
source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source $HOME/.config/zsh/zsh-autopair/autopair.zsh 2>/dev/null

source "$HOME/.profile"

#LF
[ -f ~/.config/lf/LF_ICONS ] && {
	LF_ICONS="$(tr '\n' ':' <~/.config/lf/LF_ICONS)" \
		&& export LF_ICONS
    [ -f "$HOME/.config/lf/LF_COLORS" ] && source "$HOME/.config/lf/LF_COLORS"
}

startSession(){
    neofetch
    source "$HOME/.profile"
    printf "Welcome back buddy! ^^\n"
    printf "Logging in...\n"

    sleep 1
    pgrep dwm || startx "$HOME/.xinitrc"
}

#APPLY PROMTS
apply_starship_promt(){
	if [[ "$(tty)" == "/dev/tty1" ]]; then
        eval "$(starship init zsh)"
        export STARSHIP_CONFIG="$HOME/.config/zsh/starship/starship-tty.toml"
        startSession
    else
        eval "$(starship init zsh)"
        export STARSHIP_CONFIG="$HOME/.config/zsh/starship/starship.toml"
    fi
}

apply_p10k_promt() {
	if [[ "$(tty)" == "/dev/tty1" ]]; then
        PROMPT="%B%F{red}[%F{green}%n%f%b%B%F{yellow}@%f%b%B%F{blue}%m%f%b%F%B%F{magenta} %~%f%b %B%F{red}]%B%F{green} $%f%b "
        startSession
    else
        source $HOME/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme &>/dev/null
        source ~/.config/zsh/p10k.zsh
	fi
	return 0
}

## Applyuing promt
apply_starship_promt || apply_p10k_promt
