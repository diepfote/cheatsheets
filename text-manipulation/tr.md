# tr

## remove non-letter characters

```text
# remove non-letter characters (excluding dashes)
# (except for "-")
$ echo 'catalinö43a-' | tr -cd '[:alpha:]-'; echo -e "\n$?"
catalina-
0
```

## remove non-printable characters (ASCII)

```text
tr -cd '[:print:]\n'
```

## keep control sequences and printable characters (ASCII)

```text
$ tr -cd '[:print:][:cntrl:]' < <(echo -e 'asdf\n 34j3  . -- dsf')
asdf
 34j3  . -- dsf
```
