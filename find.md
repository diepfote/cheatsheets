# Find

## any of the given filenames

```
find  \( -name .envrc -o -name .custom-envrc \) ...

find ~/ -type f ! -executable \( -name '*vaultfile' -o -name '*ansible*vault'  \) -exec sh -c 'bat "$0"' {} \;
```

## multiple directories

```
find <dir1> <dir2> ...
```

## sort by size & filter file-extensions

```
find . -path ./.git -prune -o -type f -exec sh -c 'ls -s "$0"' {} \; | sort -n -r | grep -vE 'png|html|svg|jpg|pptx|pdf|xcf|zip'
```

## sort by last modified

```
find slides/out -printf "%T@ %Tc %p\n" 2>&1 | sort -n | grep html | cut -d ' ' -f7
```
