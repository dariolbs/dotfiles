# Promt functions
# ---------------

# Starship prompt
apply_starship_promt(){
    eval "$(starship init zsh)"
    export STARSHIP_CONFIG="$HOME/.config/zsh/starship/starship.toml"
}

# Powerlevel10k
apply_p10k_promt() {
    source "$HOME/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme" &>/dev/null
    source "$HOME/.config/zsh/powerlevel10k/config/personal/dario-default.zsh" && return 0
}

# Default prompt
apply_default_promt() {
    PROMPT="%B%F{red}[%F{green}%n%f%b%B%F{yellow}@%f%b%B%F{blue}%m%f%b%F%B%F{magenta} %~%f%b %B%F{red}]%B%F{green} $%f%b "
}

# Normal prompts
apply_colorless() {
    PROMPT="%n%f%b@%f%b%m%f%b%F{magenta} %~%f%b $%f%b "
}

# Define prompt function
export PROMPT_FUNCTION="apply_p10k_promt"
