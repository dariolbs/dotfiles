# PATH
export PATH="${PATH}:$HOME/.scripts/:$JAVA_HOME"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/.local/bin"

# Env variables
export TERMINAL="foot"
export EDITOR="nvim"

# Golang
export PATH="${PATH}:/usr/local/go/bin"
export GOPATH="/usr/local/go"

# Java
export JAVA_HOME="/usr/lib/jvm/default"

# Load personal profile
if [ -f "$HOME/Documents/profile" ]; then
    # Source for posix complient shell
    source "$HOME/Documents/profile"
fi
