# FZF

## Preview files in current dir

highlighted based on file extension

```text
fzf --height 100% --preview='file={}; bat -l "${file##*.}" --color=always {}'

fzf --height 100% --preview='file={}; bat -l "$(echo "$file" | sed "s#.*\.##g")" --color=always {}'
```

