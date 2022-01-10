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
$ man vmstat

$ free -h
```

### disks

```
# -d ... display disk utilization report
$ iostat --human --pretty -d
```

### network

```
# run once
$ sar -n DEV 1 1

# TCP stack
$ sar -n TCP,ETCP 1 1
```

### process usage

```
pidstat -p <pid>

# global
pidstat
```

## kernel errors, no journalctl - no systemd

```
dmesg | tail
```
