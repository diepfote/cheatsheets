# GH cli

## merge a PR

```
# by current branch
gh pr edit --add-label "merge"

# by PR number
gh pr edit 60 --remove-label wip --add-label merge
```

## approve PR

```
# PR by number
gh pr review 11 --approve

# PR by current branch
gh pr review --approve
```

## restart CI build

```
# by PR number
gh pr comment 114 --body 'recheck'

# by current branch
gh pr comment --body 'recheck'
```
