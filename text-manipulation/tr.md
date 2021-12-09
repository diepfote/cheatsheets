# tr

## remove non-letter characters

```
# remove non-letter characters (excluding dashes)
# (except for "-")
$ echo 'catalinö43a-' | tr -cd '[:alpha:]-'; echo -e "\n$?"
catalina-
0
```


## remove non-printable characters (ASCII)

```
tr -cd '[:print:]\n'
```


## keep control sequences and printable characters (ASCII)

```
tr -cd '[:print:][:cntrl:]'
```

