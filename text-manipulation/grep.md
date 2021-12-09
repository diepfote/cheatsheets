# grep

## -o  print only matching characters

```
$ ip addr | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' 
inet 127.0.0.1
inet 192.168.0.126
inet 10.17.0.7
```

