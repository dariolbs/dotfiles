#!/usr/bin/bash
source "$HOME/.config/hypr/scripts/tofi/tofi_options.sh"
pid="$(pidof tofi)" && kill $pid
eval "tofi ${options[@]} ${@}"
