# dd

## generate file of arbitrary size

```
arbitrary_size=4G
dd if=/dev/urandom of=/tmp/arbitrary-file.img count=0 bs=1 seek="$arbitrary_size"
```

