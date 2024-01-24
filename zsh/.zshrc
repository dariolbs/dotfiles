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

# P10k instant prompt
source "$HOME/.config/zsh/powerlevel10k/config/personal/instant_prompt.zsh"

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

# Execute default prompt function
eval "$PROMPT_FUNCTION"
