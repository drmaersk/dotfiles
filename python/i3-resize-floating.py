#! /usr/bin/env python3

import sys
import i3ipc

i3 = i3ipc.Connection()

focused = i3.get_tree().find_focused()
outputs = i3.get_outputs()

width = 0
height = 0
for output in filter(lambda o: o.active, outputs):
   if output.current_workspace == focused.workspace().name:
       width = int(output.rect.width / 2)
       height = output.rect.height

i3.command('floating enable resize set %d %d' % (width, height))
i3.command('move absolute position center')

