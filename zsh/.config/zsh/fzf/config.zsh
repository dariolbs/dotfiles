# Setup fzf
# ---------

# Auto-completion
# ---------------
source "$HOME/.config/zsh/fzf/shell/completion.zsh"

# Key bindings
# ------------
source "$HOME/.config/zsh/fzf/shell/key-bindings.zsh"

# Variables
# ------------

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
    --inline-info
    --height 90%
    --border
    --color=dark,bg+:-1
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"
    
export FZF_DEFAULT_OPTS="
    --layout=reverse
    --inline-info
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
    --height 90%
    --border
    --color=dark,bg+:-1
"
