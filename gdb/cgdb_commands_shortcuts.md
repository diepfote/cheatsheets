# 3.1 Commands available during CGDB mode

When you are in the source window, you are implicitly in "CGDB mode".
All of the below commands are available during this mode.  This mode is
primarily available for the user to view the current source file,
search it, or switch to a different mode.

```text
`cgdbmodekey'
     Puts the user into command mode. However, you are already in this
     mode.  This is defaulted to the <ESC> key.

`i'
     Puts the user into "GDB mode".

`I'
     Puts the user into "TTY mode".

`T'
     Opens a window to give input to the debugged program.

`Ctrl-T'
     Opens a new tty for the debugged program.

`k'
`up arrow'
     Move up a line.

`j'
`down arrow'
     Move down a line.

`h'
`left arrow'
     Move left a line.

`l'
`right arrow'
     Move right a line.

`Ctrl-b'
`page up'
     Move up a page.

`Ctrl-u'
     Move up 1/2 a page.

`Ctrl-f'
`page down'
     Move down a page.

`Ctrl-d'
     Move down 1/2 a page.

`gg'
     Move to the top of file.

`G'
     Move to the bottom of file.

`/'
     search from current cursor position.

`?'
     reverse search from current cursor position.

`n'
     next forward search.

`N'
     next reverse search.

`o'
     open the file dialog.

`spacebar'
     Sets a breakpoint at the current line number.

`t'
     Sets a temporary breakpoint at the current line number.

`-'
     Shrink source window 1 line.

`='
     Grow source window 1 line.

`_'
     Shrink source window 25% (or, shrink tty window 1 line, if
     visible).

`+'
     Grow source window 25% (or, grow tty window 1 line, if visible).

`Ctrl-l'
     Clear and redraw the screen.

`F5'
     Send a run command to GDB.

`F6'
     Send a continue command to GDB.

`F7'
     Send a finish command to GDB.

`F8'
     Send a next command to GDB.

`F10'
     Send a step command to GDB.
```
