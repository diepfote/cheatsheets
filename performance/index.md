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

#### pagefaults | page faults

---

Taken from: https://linoxide.com/commands-to-understand-page-faults-in-linux/

---

Field 1 - pid  
Field 2 - filename of the executable  
Field 10 - number of minor page faults  
Field 12 - number of major page faults  

```
cut -d ' ' -f 1,2,10,12 /proc/<pid>/stat
```

### memory

```text
$ man vmstat

$ free -h

# sort processes by memory consumption (gnu tools only)
$ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head
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
