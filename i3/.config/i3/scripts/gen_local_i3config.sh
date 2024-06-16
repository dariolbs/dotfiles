#!/usr/bin/bash

if [ ! -f "$HOME/.xconfig" ]; then exit 1; fi

source "$HOME/.xconfig"

cat ~/.config/i3/config

cat << EOF
# Define names for default workspaces for which we configure key bindings later on.
# We use variables to avoid repeating the names in multiple places.
# This is an example configuration for multiple monitors

workspace 1 output $primary
workspace 2 output $primary
workspace 3 output $primary
workspace 4 output $primary
workspace 5 output $primary
workspace 6 output $primary
workspace 7 output $primary
workspace 8 output $primary
workspace 9 output $primary
workspace 10 output $primary
# workspace 11 output <monitor>
# workspace 12 output <monitor>
# workspace 13 output <monitor>
# workspace 14 output <monitor>
# workspace 15 output <monitor>
# workspace 16 output <monitor>
# workspace 17 output <monitor>
# workspace 18 output <monitor>

# Switch to workspace
bindsym \$mod+1 workspace number 1
bindsym \$mod+2 workspace number 2
bindsym \$mod+3 workspace number 3
bindsym \$mod+4 workspace number 4
bindsym \$mod+5 workspace number 5
bindsym \$mod+6 workspace number 6
bindsym \$mod+7 workspace number 7
bindsym \$mod+8 workspace number 8
bindsym \$mod+9 workspace number 9
bindsym \$mod+0 workspace number 10
# bindsym \$mod+F1 workspace number 11
# bindsym \$mod+F2 workspace number 12
# bindsym \$mod+F3 workspace number 13
# bindsym \$mod+F4 workspace number 14
# bindsym \$mod+F5 workspace number 15
# bindsym \$mod+F6 workspace number 16
# bindsym \$mod+F7 workspace number 17
# bindsym \$mod+F8 workspace number 18

# Move focused container to workspace
bindsym \$mod+Shift+1 move container to workspace number 1
bindsym \$mod+Shift+2 move container to workspace number 2
bindsym \$mod+Shift+3 move container to workspace number 3
bindsym \$mod+Shift+4 move container to workspace number 4
bindsym \$mod+Shift+5 move container to workspace number 5
bindsym \$mod+Shift+6 move container to workspace number 6
bindsym \$mod+Shift+7 move container to workspace number 7
bindsym \$mod+Shift+8 move container to workspace number 8
bindsym \$mod+Shift+9 move container to workspace number 9
bindsym \$mod+Shift+0 move container to workspace number 10
# bindsym \$mod+Shift+F1 move container to workspace number 11
# bindsym \$mod+Shift+F2 move container to workspace number 12
# bindsym \$mod+Shift+F3 move container to workspace number 13
# bindsym \$mod+Shift+F4 move container to workspace number 14
# bindsym \$mod+Shift+F5 move container to workspace number 15
# bindsym \$mod+Shift+F6 move container to workspace number 16
# bindsym \$mod+Shift+F7 move container to workspace number 17
# bindsym \$mod+Shift+F8 move container to workspace number 18
EOF
