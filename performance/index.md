# Performance

## USE Method
snatched from https://brendangregg.com/usemethod.html &  
youtube: Container Performance Analysis-bK9A5ODIgac

### cpu

```
# all cpus
mpstat -P ALL

# cpu 1
mpstat -P 1
```

### memory

```
man vmstat
```

### disks

```
# -d ... display disk utilization report
$ iostat --human --pretty -d
```

