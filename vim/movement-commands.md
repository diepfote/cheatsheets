# Movement commands

```text
ge      End of previous word
gE      End of previous WORD


},{     Beginning of next, current paragraph

num|    Column num of current line
g0,g$   First, last position of screen line

*       Search forward for word under cursor. Exact word
#       Search backward ---             ||            --

g*      Search forward for word unser cursor. Matches characters in this word
        when embedded in a longer word.
g#      Search backward for word --           ||                           --

%       Find match of current parenthesis, brace or bracket

,       Reverse search direction of last f,F,t or T
;       Repeat last f,F,t or T


``      Return to position before most recent jump
`.      Move to last change in file (for me it is '.)
'0      Position where you last exited vim
```
