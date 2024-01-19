# Tmux and ssh | Tmux and ssh

## Kubectl exec multiple pods simultaneoulsy

* exits shell window in which this command is run
* add `; bash` after `kubectl exec` command if you do not want the pane to be closed on pod exit
* counts down available space in terminal emulator to be able to open as many panes as possible -> `available_horizontally`

```text
available_horizontally="$(tmux display -p -t . '#{pane_width}')"; pod_ids=(0 1 2 3 4 5 6 7); for pod_id in "${pod_ids[@]}"; do
  tmux split-window -v -p "$available_horizontally" bash -i -c "set-kubecontext <filename>; kubectl exec -it -n <NAMESPACE> <sts-name->$pod_id -- sh"; available_horizontally=$(( $available_horizontally - 5 )); done  ;  tmux select-layout even-vertical; exit
```
