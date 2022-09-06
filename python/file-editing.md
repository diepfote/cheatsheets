# File editing

## consume first line in File

```
def eat_first_line(fpath):
    '''
    most of it snatched from https://stackoverflow.com/a/39791546
    '''

    new_fpath = f'{fpath}.new'
    source_file = open(fpath, 'r')

    # eat line
    source_file.readline()

    # this will truncate the file, so need to use a different file name:
    target_file = open(new_fpath, 'w')

    # copy contents from original file; omit first line (first line consumed)
    shutil.copyfileobj(source_file, target_file)

    # replace original file
    shutil.move(new_fpath, fpath)
```
