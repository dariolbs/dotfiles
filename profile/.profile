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
export JAVA_HOME="/usr/lib/jvm/default"

# Haskell
[ -f "/home/dario/.ghcup/env" ] && . "/home/dario/.ghcup/env" # ghcup-env
