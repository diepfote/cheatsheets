# Find

## prune folders and subfolders/do not show folders and subfolders

```text
$ find "$HOME/Movies/" -path "$HOME/Movies/watched/*" -prune -o -path "$HOME/Movies/audio-only/*" -o -path "$HOME/Movies/TV" -prune -o -type f -print | grep -E 'watched|TV|audio-only'  # 2023-07-25
/Users/florian.sorko/Movies/Maybe at some Point/totalbiscuit/Legacy of the Void/TB plays Protoss in LOTV - Daily Adept Nerfathon (October 11, 2015).mp4
```

## any of the given filenames

```text
find  \( -name .envrc -o -name .custom-envrc \) ...

find ~/ -type f ! -executable \( -name '*vaultfile' -o -name '*ansible*vault'  \) -exec sh -c 'bat "$0"' {} \;
```

## multiple directories

```text
find <dir1> <dir2> ...
```

## sort by size & filter file-extensions

```text
find . -path ./.git -prune -o -type f -exec sh -c 'ls -s "$0"' {} \; | sort -n -r | grep -vE 'png|html|svg|jpg|pptx|pdf|xcf|zip'
```

## sort by last modified

```text
find slides/out -printf "%T@ %Tc %p\n" 2>&1 | sort -n | grep html | cut -d ' ' -f7
```

## Find images by creation date

Use exiftool instead of `find -newer ... -! o newer ...`

```text
exiftool -r -if '$CreateDate =~ /^2024:06:15 14:04/' -filename -createdate 2024-07-*
```

