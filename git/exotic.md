# Git Exotic

## Add local only excludes in git repo

```
$GIT_DIR/info/exclude
```

## show top-level of git repo

```
git rev-parse --show-toplevel
```

## remove files from all git commits

taken from https://improveandrepeat.com/2021/06/how-to-use-git-filter-repo-to-remove-files-from-your-git-repository/

```
# To check what will be deleted run with --dry-run and remove --invert-paths
# --> will only add matched commits (commits you want to delete --> invert)
git filter-repo --dry-run --path specific-file-or-dir/ --path-glob '*partial-name-in-subfolder*'

# --invert-paths --> to exclude these matches, otherwise all other
# commits would be dropped
git filter-repo --invert-paths --path specific-file-or-dir/ --path-glob '*partial-name-in-subfolder*'

```

## filter mail addresses from repo

Snatched from https://www.scivision.dev/git-update-email-address/

### mailcap file

```
Jane Doe <jane@NEW.com> <jane@OLD.com>
John Smith <john@NEW.com> <john@OLD.com>
```
### command

```
git filter-repo --mailmap mailmap
```

## filter git diff

```
git diff origin/master  --name-only | grep -vE 'Pipfile|cert-state.vault.yaml'  | xargs git diff --word-diff origin/master --
```

## diff color moved
https://twitter.com/offlinemark/status/1430975771363921922/photo/4

```
git diff --color-moved
git diff --color-moved=dimmed-zebra
git diff --color-moved-ws=allow-indentation-change
```

## display only names of changed files

```
git l --name-only
git diff --name-only
git show --name-only
```

## preserve merge commits on (interactive) rebase

```
git rebase -r
```


## rebase onto another branch

snatched from https://nedbatchelder.com/blog/202202/moving_a_git_branch_to_a_new_base.html

```
git checkout <branch-to-rebase>
git rebase --onto <new-revision> "$(git merge-base <old-revision> @)"
```

## use commit message instead of hash to display information about commit

Snatched from https://twitter.com/offlinemark/status/1387833240321417222

  * `<rev>^{/<text>}, e.g. HEAD^{/fix nasty bug}`
  A suffix `^` to a revision parameter, followed by a brace pair that contains a text led by a slash, is the same as the `:/fix nasty bug` syntax below except that it returns the youngest matching commit which is reachable from the `<rev>` before `^`.

```
git show :/<pattern to match youngest commit message>
```

## git clang-format

Snatched from https://offlinemark.com/2021/04/02/surgical-formatting-with-git-clang-format/

### one commit
* Change files to your heart’s content. Be messy.
* Stage your changes by running git add
* Format changes by running git clang-format


### messy dev branch

* Make a new dev branch and squash all commits into one using git rebase
* Use git reset --soft to bring the single squashed commit into the staging tree
* Run git clang-format to format the squashed commit and add formatting changes to working tree
* git checkout back to original dev branch to apply the formatting changes for the whole branch in one commit

### alternate format

```
$ git clang-format --style=WebKit
$ git clang-format --style=file # if you have an existing .clang-format
```

## Git Blame flags

unknown origin

```
$ git blame -w  # ignores white space
$ git blame -M  # ignores moving text
$ git blame -C  # ignores moving text into other files
```

## Git Grep flags

snatched from <https://github.blog/2018-09-10-highlights-from-git-2-19>

Display entire c lang function if there is a result.

```
git grep --function-context/-W
```


## Git log flags

snatched from <https://github.blog/2019-11-03-highlights-from-git-2-24/>

Not using the standard `--` was an intentional choice here, since this is already a widely-used mechanism in Git to separate reference names from files. 

```
git log --end-of-options --super-dangerous-option
```

## Git refspec explained

snatched from <https://github.blog/2020-10-19-git-2-29-released/>

This refspec tells Git to fetch what’s on the left side of the colon (everything in refs/heads/; i.e., all branches) and to write them into the hierarchy on the right-hand side. The \* means “match everything” on the left-hand side and “replace with the matched part” on the right-hand side.

```
* git config remote.origin.fetch
+refs/heads/*:refs/remotes/origin/*
```

## Git stash flags

stash content in index/stash staged content

```
git stash -p
git stash --staged
```
