# File editing

## consume first line in File

```text
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

## convert pickled dict to json | convert dict in a text file to json

```text
#!/usr/bin/env python3

# very much inspired by https://www.geeksforgeeks.org/how-to-read-dictionary-from-file-in-python/

import sys
import ast
import json

pattern = ", {'path':"

for line in sys.stdin:
    if pattern in line:
        paths = line.split(pattern)
        for path in paths:
            sanitized_path = f"{{'path':{path}"
    else:
        sanitized_path = line

    loaded_dict = ast.literal_eval(sanitized_path)
    print(json.dumps(loaded_dict))
```
