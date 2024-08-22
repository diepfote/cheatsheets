# bash completion

## basic

```text
$ blub() { COMPREPLY=(); COMPREPLY+=('asdf3'); COMPREPLY+=(3424); compopt -o nospace; }
$ complete -o filenames -F blub test

$ test
3424   asdf3
```

## find which function is registered for completion

https://stackoverflow.com/a/31073384

```text
$ complete -p yay
complete yay

$ complete -p yay-all
complete -F _yay-all_completions yay-all
```
