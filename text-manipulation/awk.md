# awk

## environment variables

```text
read -rp 'Enter a search value: ' value
((${#value} <= 1000)) || die "No, I don't think so"
search="$value" awk '$0 ~ ENVIRON["search"] {print $1}' "$file"
```

## replace every newline character with a space except for every third

remove new line characters but keep every third:

```text
$ printf '1\n2\n3\n4\n5\n6\n7' | awk 'NR %3 != 0 {printf "%s ", $0; next} 1'
1 2 3
4 5 6
7 
```

## replace cut -d | custom field widths

```text
awk 'BEGIN{FIELDWIDTHS = "10 25 9"}; {print $3 $2 $1}' file
```

## Print column n to last | Print all but column x

Snatched from <https://stackoverflow.com/a/2961994>

e.g. Remove first three columns

```text
awk '{$1=$2=$3=""; print $0 }' <file>
```
