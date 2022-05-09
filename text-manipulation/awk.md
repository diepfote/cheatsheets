# awk

## environment variables

```
read -rp 'Enter a search value: ' value
((${#value} <= 1000)) || die "No, I don't think so"
search="$value" awk '$0 ~ ENVIRON["search"] {print $1}' "$file"
```



##  replace cut -d | custom field widths

```
awk 'BEGIN{FIELDWIDTHS = "10 25 9"}; {print $3 $2 $1}' file
```

## Print column n to last | Print all but column x

Snatched from https://stackoverflow.com/a/2961994

e.g. Remove first three columns
```
awk '{$1=$2=$3=""; print $0 }' <file>
```
