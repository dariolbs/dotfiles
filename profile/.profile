# PATH
export PATH="$HOME/.local/bin/:${PATH}:$HOME/.scripts/bin/:$HOME/.scripts/handy:$HOME/.scripts/startup:$HOME/.scripts/sync:$HOME/.scripts/statusbar/dwmblocks:$JAVA_HOME"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/.local/bin"

# Env variables
export TERMINAL="foot"
export EDITOR="nvim"

# Golang
export PATH=${PATH}:/usr/local/go/bin
export GOPATH="/usr/local/go"

# Java
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"

# Fix java GUI apps not working properly
# export _JAVA_AWT_WM_NONREPARENTING=1

# LF Icons
[ -f ~/.config/lf/LF_ICONS ] && {
	LF_ICONS="$(tr '\n' ':' <~/.config/lf/LF_ICONS)" \
		&& export LF_ICONS
    [ -f "$HOME/.config/lf/LF_COLORS" ] && source "$HOME/.config/lf/LF_COLORS"
}

# Haskell
[ -f "/home/dario/.ghcup/env" ] && . "/home/dario/.ghcup/env" # ghcup-env
