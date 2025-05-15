alias la="eza --classify --git -lA"
alias ll="eza --classify --git -l"
alias ls="eza --classify -G"
alias sl="eza --classify -G"
alias tree='eza --classify -T'
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias hw='hwinfo --short'
alias rmpkg="sudo pacman -Rdd"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias e='nvim $(fzf)'
alias open='xdg-open'
alias diff='diff -u'
alias tb="nc termbin.com 9999"
alias radio="~/.venv/bin/radio"
alias lf="~/.config/lf/lf-ueberzug || lf"
alias winexp='WINEPREFIX=$HOME/.wine_xp wine'
alias nf='notify-send "command finished running!"'
alias gitlog='git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias tra='trash-put -v'
alias trr='trash-restore'
alias rm='rm -v'
alias upd='/usr/bin/update'
alias vdir='vdir --color=auto'
alias wget='wget -c '
alias rot13='tr "A-Za-z" "N-ZA-Mn-za-m"'
alias shred="shred --zero"
alias aquario="asciiquarium"
alias za="zathura"
alias updategrub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias v='vim'
alias nv='nvim'
alias nb="newsboat"
alias wireless="sudo ip link set wlp2s0 up"
alias cal="calcurse"
alias nm="neomutt"
alias ncm="ncmpcpp"
alias t='task'

# YOUTUBE-DL
alias ytm4a='yt-dlp -x -f "bestaudio[ext=m4a]" --add-metadata --embed-thumbnail'
alias ytopus='yt-dlp -x -f bestaudio --add-metadata'
alias ytmp4='yt-dlp -f mp4 --add-metadata --embed-thumbnail'
 
# JAVA
alias java8="/usr/lib/jvm/java-8-openjdk/bin/java"
alias javac8="/usr/lib/jvm/java-8-openjdk/bin/javac"
