# Git Filter Repo 

`git filter-repo`


## rewrite committer and author dates

`--refs` ... limit the number of commits we rewrite
             (in this case only commits on feature branch)

```
git filter-repo --refs origin/master..HEAD --commit-callback date_callback.py --force
```

[date_callback.py](./date_callback.py)



## remove files from all git commits

taken from <https://improveandrepeat.com/2021/06/how-to-use-git-filter-repo-to-remove-files-from-your-git-repository/>

```sh
# To check what will be deleted run with --dry-run and remove --invert-paths
# --> will only add matched commits (commits you want to delete --> invert)
git filter-repo --dry-run --path specific-file-or-dir/ --path-glob '*partial-name-in-subfolder*'

# --invert-paths --> to exclude these matches, otherwise all other
# commits would be dropped
git filter-repo --invert-paths --path specific-file-or-dir/ --path-glob '*partial-name-in-subfolder*'

```

## filter mail addresses from repo

Snatched from <https://www.scivision.dev/git-update-email-address/>

### mailcap file

```sh
Jane Doe <jane@NEW.com> <jane@OLD.com>
John Smith <john@NEW.com> <john@OLD.com>
```

### command

```sh
git filter-repo --mailmap mailmap
```

