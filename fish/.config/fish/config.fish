if status is-interactive

    # Commands to run in interactive sessions can go here
    source "$HOME/.config/fish/aliases.fish"

    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual block

    function last_history_item
        echo $history[1]
    end
    abbr -a !! --position anywhere --function last_history_item

    set -U fish_greeting

    starship init fish | source

    # yazi
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    alias lf="y"

    # Source environment variables
    source "$HOME/.config/fish/env.fish"
    source "$HOME/.config/fish/paths.fish"
end
