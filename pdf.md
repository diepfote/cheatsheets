# PDF

## Extract page range

```text
pdftk <source-file> cat <start>-<end> output <dst-file>
```

## count number of pages in pdf files in current dir

snatched parts from <https://apple.stackexchange.com/a/198860>

```text
exiftool *.pdf | awk -F": " '/Page Count/{print $2}' | tr '\n' + | sed 's#+$#\n#' | bc
```

