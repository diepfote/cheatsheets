# Git Completions

https://github.com/git/git/blob/master/contrib/completion/git-completion.bash

## complete complex functions

```
# If you use complex aliases of form '!f() { ... }; f', you can use the null
# command ':' as the first command in the function body to declare the desired
# completion style. For example '!f() { : git commit ; ... }; f' will
# tell the completion to use commit completion. This also works with aliases
# of form "!sh -c '...'". For example, "!sh -c ': git commit ; ... '".
```

## complete external commands

```
# If you have a command that is not part of git, but you would still
# like completion, you can use __git_complete:
#
# __git_complete gl git_log
```
