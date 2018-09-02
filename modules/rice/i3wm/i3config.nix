{ config-extra, pkgs, config}:
let colors = import ../../colors.nix; in
with colors;
''
set $workspace1 1
set $workspace2 2
set $workspace3 3
set $workspace4 4
set $workspace5 5
set $workspace6 6
set $workspace7 7
set $workspace8 8
set $workspace9 9
set $workspace10 10

font pango:Ubuntu 12

# class                 container-border    container-backgr  text          indicator   window-border
client.focused          ${mlight}           ${mlight}         ${dark}       ${accent}   ${mlight}
client.focused_inactive ${mdark}            ${mdark}          ${light}      ${accent}   ${mdark}
client.unfocused        ${dark}             ${mdark2}         ${mlight}     ${accent}   ${mdark2}
client.urgent           ${accent}           ${dark}           ${light}      ${dark}     ${accent}
client.placeholder      ${mdark}            ${mdark}          ${light}      ${accent}   ${mdark}

client.background       ${light}

bar {
  position top
	status_command i3status --config ${pkgs.writeTextFile {
    name = "i3status.conf";
    text = import ./i3status.nix { inherit colors; };
    }
  }
  separator_symbol " · "
  
  colors {
    background ${dark}
    statusline ${light}
    separator ${accent}

    #                   border    background  text
    focused_workspace  ${dark}    ${dark}   ${mlight}
    active_workspace   ${dark}    ${dark}   ${mlight}
    inactive_workspace ${dark}    ${dark}    ${mdark}
    urgent_workspace   ${accent}    ${dark} ${accent}
    binding_mode       ${dark}    ${dark}  ${accent}
  }
}

for_window [class=".*"] border pixel 5

for_window [class="Pavucontrol"] floating enable
for_window [class="Pavucontrol"] resize set 640 480
for_window [class="Arandr"] floating enable
for_window [class="Arandr"] resize set 640 480
for_window [class="pyqt_hello.py"] floating enable
for_window [class="pyqt_hello.py"] resize set 640 480


exec --no-startup-id pnmixer
exec --no-startup-id nm-applet 

exec --no-startup-id /home/robban/Dev/dotfiles_laptop/python/screen_operations.py auto
exec --no-startup-id feh --bg-fill /home/robban/.config/wallpaper.jpg
exec --no-startup-id xset s off -dpms
exec --no-startup-id clipit

${import config-extra {inherit pkgs config;}}

''
