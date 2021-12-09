# Magic

Vim's default 'magic' setting makes characters have the same meaning as in grep, and \v (very magic) makes them the same as the extended regular expressions used by egrep.

Regular expressions in scripts should always specify one of \v, \m, \M, or \V, to make them immune to the user's 'magic' setting.

The :substitute command has the :smagic and :snomagic alternate forms (the same as \m and \M), so you can search and replace with %sno/regex/new_text/g. Alternatively, you might find it helpful to refine your regular expression *by searching with `/\v` first*, then you can insert your regular expression by typing:

```
:s/<Ctrl-R>/ 
```


Sidenote: further info at <https://vim.fandom.com/wiki/Simplifying_regular_expressions_using_magic_and_no-magic>
