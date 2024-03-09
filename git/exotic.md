# Git Exotic

## Add local only excludes in git repo

```sh
$GIT_DIR/info/exclude
```

## show top-level of git repo

```sh
git rev-parse --show-toplevel
```

## filter git diff

```sh
git diff origin/master  --name-only | grep -vE 'Pipfile|cert-state.vault.yaml' \
   | xargs git diff --word-diff origin/master --
```

## diff color moved

<https://twitter.com/offlinemark/status/1430975771363921922/photo/4>

```sh
git diff --color-moved
git diff --color-moved=dimmed-zebra
git diff --color-moved-ws=allow-indentation-change
```

## display only names of changed files

```sh
git l --name-only
git diff --name-only
git show --name-only
```

## preserve merge commits on (interactive) rebase

```sh
git rebase -r
```

## rebase onto another branch

snatched from <https://nedbatchelder.com/blog/202202/moving_a_git_branch_to_a_new_base.html>

```sh
git checkout <branch-to-rebase>
git rebase --onto <new-revision> "$(git merge-base <old-revision> @)"
```

## use commit message instead of hash to display information about commit

Snatched from <https://twitter.com/offlinemark/status/1387833240321417222>

* `<rev>^{/<text>}, e.g. HEAD^{/fix nasty bug}`
  A suffix `^` to a revision parameter, followed by a brace pair that
  contains a text led by a slash, is the same as the `:/fix nasty bug`
  syntax below except that it returns the youngest matching commit
  which is reachable from the `<rev>` before `^`.

```sh
git show :/<pattern to match youngest commit message>
```

## git clang-format

Snatched from <https://offlinemark.com/2021/04/02/surgical-formatting-with-git-clang-format/>

### one commit

* Change files to your heart’s content. Be messy.
* Stage your changes by running git add
* Format changes by running git clang-format

### messy dev branch

* Make a new dev branch and squash all commits into one using git rebase
* Use git reset --soft to bring the single squashed commit into the staging tree
* Run git clang-format to format the squashed commit and add formatting changes
  to working tree
* git checkout back to original dev branch to apply the formatting changes for
  the whole branch in one commit

### alternate format

```sh
git clang-format --style=WebKit
git clang-format --style=file # if you have an existing .clang-format
```

## Git Blame flags

unknown origin

```sh
git blame -w  # ignores white space
git blame -M  # ignores moving text
git blame -C  # ignores moving text into other files
```

## Git Grep flags

snatched from <https://github.blog/2018-09-10-highlights-from-git-2-19>

Display entire c lang function if there is a result.

```sh
git grep --function-context/-W
```

## Git log flags

snatched from <https://github.blog/2019-11-03-highlights-from-git-2-24/>

Not using the standard `--` was an intentional choice here, since this is
already a widely-used mechanism in Git to separate reference names from files.

```sh
git log --end-of-options --super-dangerous-option
```

## Git refspec explained

snatched from <https://github.blog/2020-10-19-git-2-29-released/>

This refspec tells Git to fetch what’s on the left side of the colon
(everything in refs/heads/; i.e., all branches) and to write them into
the hierarchy on the right-hand side. The \* means “match everything”
on the left-hand side and “replace with the matched part” on the right-hand side.

```sh
git config remote.origin.fetch
+refs/heads/*:refs/remotes/origin/*
```

## Git stash flags

stash content in index/stash staged content

```sh
git stash -p
git stash --staged
```

## Git fix repository corruption |  Git refetch the entire branch content/repo

snatched from <https://github.blog/2022-04-18-highlights-from-git-2-36/>

If there is content missing from the repo, a refetch all might help:

```sh
git fetch --refetch
```

## Get type of git object | Show type of git ref | What type does this git hash refer to

```
$ git cat-file -t refs/magic/value
blob
$ git show refs/magic/value
1705590754643
```

## Show root commit

nicked from <https://stackoverflow.com/a/5189296>

```
git log --max-parents=0
```

