```
$ blub() { COMPREPLY=(); COMPREPLY+=('asdf3'); COMPREPLY+=(3424); compopt -o nospace; }
$ complete -o filenames -F blub test

$ test
3424   asdf3
```
