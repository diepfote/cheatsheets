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

