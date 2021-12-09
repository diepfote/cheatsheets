# Git remove stale refs

```
git reflog expire --expire=now --all; git gc --prune=now --aggressive
```
