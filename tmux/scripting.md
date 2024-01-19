# Tmux scripting

Information gathered from <https://unix.stackexchange.com/a/649752>

Important comment. Quote:

```text
Careful with using a for loop with the output of all. Would recommend including #{pane_active} in your format, then sort on that column. This way the last pane to be closed will be the active one you are on. If you dont do this the for loop will work though every entry in the list provided from the output of tmux list-panes -a -F "#D", and if your script is in the middle it will stop before the rest of the entries are complete. –
Dave
Aug 4, 2022 at 14:28
```

## set pane title

***CAREFUL***:
for some reason this breaks CWD (resets it) if you use `tmux-resurrect`

```text
while read -r pane; do tmux select-pane -t "$pane" -T ''; done < <(tmux list-panes -a -F "#{pane_active} #{window_active} #{pane_id}" | sort | awk '{print $3}')
```

## respawn all panes

currently focused pane will respawn last

```text
while read -r pane; do tmux respawn-pane -k -t "$pane"; done < <(tmux list-panes -a -F "#{pane_active} #{window_active} #{pane_id}" | sort | awk '{print $3}')
```
