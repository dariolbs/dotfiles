# PERL LSP
PATH="/home/dario/.local/progtools/perl5/bin:${PATH}"; export PATH;
PERL5LIB="/home/dario/.local/progtools/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/dario/.local/progtools/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/dario/.local/progtools/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/dario/.local/progtools/perl5"; export PERL_MM_OPT;
# RUBY LSP
PATH="/home/dario/.local/share/gem/ruby/3.0.0/bin:${PATH}"; export PATH;

# PATH
export PATH="$HOME/.local/bin/:${PATH}:$HOME/.scripts/bin/:$HOME/.scripts/handy:$HOME/.scripts/startup:$HOME/.scripts/sync:$HOME/.scripts/statusbar/dwmblocks:$JAVA_HOME"
export PATH="$PATH:$HOME/.bin"

export TERMINAL="foot"
export EDITOR="nvim"
export HAMACHI="logmein-hamachi.service"
export STEAMSCREENSHOTS="/home/dario/.local/share/Steam/userdata/250615889"

# Golang
export PATH=${PATH}:/usr/local/go/bin
export GOPATH="/usr/local/go"

# JAVA 💀💀💀
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"

# RUBY
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"

# FCUL
export PATH="$PATH:$HOME/.bin/sqlcl_fcul/bin/"
