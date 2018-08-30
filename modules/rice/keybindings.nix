{ pkgs, ...}:
''
set $mod Mod4

floating_modifier $mod

bindsym $mod+r exec svarog-rofi -show run
bindsym $mod+Tab exec svarog-rofi -show window
#bindsym $mod+p exec svarog-rofi -show ssh
bindsym $mod+t exec svarog-urxvt
bindsym $mod+w kill
bindsym $mod+l exec arandr
bindsym $mod+e exec svarog-urxvt -e ranger
bindsym $mod+b exec --no-startup-id /home/robban/dev/python/pyqt_hello.py
#bindsym $mod+c exec clipster -sp

# change focus
#bindsym $mod+h focus left
#bindsym $mod+t focus down
#bindsym $mod+n focus up
#bindsym $mod+s focus right
bindsym $mod+BackSpace exec --no-startup-id /home/robban/dev/python/screen_operations.py auto
bindsym $mod+Shift+BackSpace exec --no-startup-id /home/robban/dev/python/screen_operations.py toggle

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in vertical orientation
bindsym $mod+v split v
bindsym $mod+h split h
#bindsym $mod+, DISPLAY=:0 xdotool keyup super

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle
bindsym $mod+Shift+f exec --no-startup-id /home/robban/dev/python/i3-resize-floating.py

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+o layout stacking
bindsym $mod+ä layout tabbed
bindsym $mod+ö layout toggle split

# toggle tiling / floating
bindsym $mod+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+Shift+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# switch to workspace
bindsym $mod+1 workspace $workspace1
bindsym $mod+2 workspace $workspace2
bindsym $mod+3 workspace $workspace3
bindsym $mod+4 workspace $workspace4
bindsym $mod+5 workspace $workspace5
bindsym $mod+6 workspace $workspace6
bindsym $mod+7 workspace $workspace7
bindsym $mod+8 workspace $workspace8
bindsym $mod+9 workspace $workspace9
bindsym $mod+0 workspace $workspace10

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace $workspace1
bindsym $mod+Shift+2 move container to workspace $workspace2
bindsym $mod+Shift+3 move container to workspace $workspace3
bindsym $mod+Shift+4 move container to workspace $workspace4
bindsym $mod+Shift+5 move container to workspace $workspace5
bindsym $mod+Shift+6 move container to workspace $workspace6
bindsym $mod+Shift+7 move container to workspace $workspace7
bindsym $mod+Shift+8 move container to workspace $workspace8
bindsym $mod+Shift+9 move container to workspace $workspace9
bindsym $mod+Shift+0 move container to workspace $workspace10

bindsym $mod+Prior workspace prev
bindsym $mod+Next workspace next
bindsym $mod+Shift+Prior move container to workspace prev
bindsym $mod+Shift+Next move container to workspace next

# volume control
# amixer -q sset Master,0 1+ unmute
bindsym XF86AudioLowerVolume exec amixer -q sset Master 3%-
bindsym XF86AudioRaiseVolume exec amixer -q sset Master 3%+
bindsym XF86AudioMute exec amixer -q sset Master toggle

# Sreen brightness controls
bindsym XF86MonBrightnessUp exec xbacklight -inc 20 # increase screen brightness
bindsym XF86MonBrightnessDown exec xbacklight -dec 20 # decrease screen brightness

# connect to my bt headset
#bindsym $mod+Shift+F12 exec echo "connect 00:16:94:1B:01:D8" | bluetoothctl
#bindsym $mod+F12 exec echo "disconnect 00:16:94:1B:01:D8" | bluetoothct

bindsym $mod+F1 exec --no-startup-id /home/robban/dev/python/audio/bluetooth_menu.py
bindsym $mod+F2 exec --no-startup-id /home/robban/dev/python/audio/soundcard_menu.py

bindsym $mod+F12 exec --no-startup-id /home/robban/dev/scripts/toggle_dvorak.sh

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}

bindsym $mod+p mode "resize"
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"
bindsym $mod+Shift+z move scratchpad

bindsym $mod+Control+l exec ${pkgs.i3lock-fancy}/bin/i3lock-fancy
focus_follows_mouse no
''
