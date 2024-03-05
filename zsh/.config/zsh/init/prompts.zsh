# ---------------
# - All prompts -
# ---------------

# Starship prompt
apply_starship(){
    export STARSHIP_CONFIG="$HOME/.config/zsh/starship/starship.toml"
    # Put a blankline on all prompts except the first one
    precmd() { precmd() { echo } }
    alias clear="clear; precmd() { precmd() { echo } }"
    eval "$(starship init zsh)"
}

# Powerlevel10k
apply_p10k() {
    source "$HOME/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme" &>/dev/null
    source "$HOME/.config/zsh/powerlevel10k/config/personal/dario-default.zsh" && return 0
}

apply_pure() {
    fpath+=($HOME/.config/zsh/zsh-pure)
    autoload -U promptinit; promptinit
    prompt pure
}

# Default prompt
apply_default() {
    autoload -Uz vcs_info
    precmd_vcs_info() { vcs_info }
    precmd_functions+=( precmd_vcs_info )
    setopt prompt_subst
    RPROMPT='${vcs_info_msg_0_}'
    zstyle ':vcs_info:git:*' formats '%F{green}%b'
    precmd() { precmd() { echo } }
    alias clear="clear; precmd() { precmd() { echo } }"

    PROMPT="%B%F{green}%n%f%b%B%F{green}@%f%b%B%F{green}%m%f%b %B%F{magenta}%~%f%b $ "
}
