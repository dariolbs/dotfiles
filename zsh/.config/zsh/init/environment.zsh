# Environment variables
# ---------------------

export DESKTOP_HOSTNAME="potente"
export LAPTOP_HOSTNAME="portatil"
export TELE="u0_a265@dariotele"
export EDITOR="nvim"

#LF ICONS
[ -f ~/.config/lf/LF_ICONS ] && {
	LF_ICONS="$(tr '\n' ':' <~/.config/lf/LF_ICONS)" \
		&& export LF_ICONS
    [ -f "$HOME/.config/lf/LF_COLORS" ] && source "$HOME/.config/lf/LF_COLORS"
}

