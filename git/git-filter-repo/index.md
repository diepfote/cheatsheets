# Git Filter Repo 

`git filter-repo`


## rewrite committer and author dates

`--refs` ... limit the number of commits we rewrite
             (in this case only commits on feature branch)

```
git filter-repo --refs origin/master..HEAD --commit-callback date_callback.py --force
```

`date_callback.py`:

```
from datetime import datetime, timezone
import sys

def fix_date(original_date):
    # original_date: "1633431022 +0000"
    # Split the string to extract the timestamp
    timestamp_str, tz_offset = original_date.split()

    timestamp = int(timestamp_str)
    old = datetime.fromtimestamp(timestamp, tz=timezone.utc)

    now = datetime.now()

    if old.year == now.year and \
       old.month == now.month and \
       old.day == now.day and old.weekday() in [5]:

        # TODO @2024-03-09 this callback only works on Saturdays
        #
        # if commit from today (Saturday) change it to Friday

        new_date = datetime(old.year, old.month, old.day-1, old.hour, old.minute, old.second)
        new_ts = int(new_date.timestamp())
        new_ts = f'{new_ts} +0000'
        return new_ts.encode('utf-8')
    else:
        return original_date

def rewrite_dates(commit, _):
    commit.author_date = fix_date(commit.author_date)
    commit.committer_date = fix_date(commit.committer_date)

rewrite_dates(commit, None)
```

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

