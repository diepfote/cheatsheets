# vimgrep to quickfix list

```vim
" recursively search for pattern in .sh files in current project root
" :copen -> open in quickfix list
:vimgrep /pattern/[gj] **.sh | :copen
```

