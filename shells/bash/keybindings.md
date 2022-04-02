# Bash keybindings

## keybinds to readline functions

```
$ bind -p | grep beginning
"\e<": beginning-of-history
"\C-a": beginning-of-line
"\eOH": beginning-of-line
"\e[1~": beginning-of-line
"\e[H": beginning-of-line
...
```

```
$ bind -P

abort can be found on "\C-g", "\C-x\C-g", "\e\C-g".
accept-line can be found on "\C-j", "\C-m".
alias-expand-line is not bound to any keys
arrow-key-prefix is not bound to any keys
backward-byte is not bound to any keys
...
```

## readline macros

```
$ bind -S
\C-r outputs \C-x1\e^\er

$ bind -s
"\C-r": "\C-x1\e^\er"
```

## bindings to shell commands

```
$ bind -X
"\C-x1": "__fzf_history"
```

