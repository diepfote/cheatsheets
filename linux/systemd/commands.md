# Systemd Commands

## systemd command cheatsheet
https://gist.github.com/rusty-snake/e0d89f6b87521fe63bc47cb813d9405f

## get control group information about a process

```
$ ls -alh /sys/fs/cgroup/"$(awk -F : '{ print $3 }' < /proc/<PID>/cgroup)"
```

### Show all displayable values for the group it resides in 

<details><summary></summary><p>

```
$ ls -alh /sys/fs/cgroup/"$(awk -F : '{ print $3 }' < /proc/740/cgroup)"
total 0
drwxr-xr-x  2 root root 0 Nov 28 20:52 .
drwxr-xr-x 10 root root 0 Nov 28 20:58 ..
-r--r--r--  1 root root 0 Nov 28 20:57 cgroup.controllers
-r--r--r--  1 root root 0 Nov 28 20:52 cgroup.events
-rw-r--r--  1 root root 0 Nov 28 20:57 cgroup.freeze
--w-------  1 root root 0 Nov 28 20:57 cgroup.kill
-rw-r--r--  1 root root 0 Nov 28 20:57 cgroup.max.depth
-rw-r--r--  1 root root 0 Nov 28 20:57 cgroup.max.descendants
-rw-r--r--  1 root root 0 Nov 28 20:52 cgroup.procs
-r--r--r--  1 root root 0 Nov 28 20:57 cgroup.stat
-rw-r--r--  1 root root 0 Nov 28 20:52 cgroup.subtree_control
-rw-r--r--  1 root root 0 Nov 28 20:57 cgroup.threads
-rw-r--r--  1 root root 0 Nov 28 20:57 cgroup.type
-rw-r--r--  1 root root 0 Nov 28 20:52 cpu.idle
-rw-r--r--  1 root root 0 Nov 28 20:52 cpu.max
-rw-r--r--  1 root root 0 Nov 28 20:57 cpu.max.burst
-rw-r--r--  1 root root 0 Nov 28 20:57 cpu.pressure
-rw-r--r--  1 root root 0 Nov 28 20:52 cpuset.cpus
-r--r--r--  1 root root 0 Nov 28 20:57 cpuset.cpus.effective
-rw-r--r--  1 root root 0 Nov 28 20:57 cpuset.cpus.partition
-rw-r--r--  1 root root 0 Nov 28 20:52 cpuset.mems
-r--r--r--  1 root root 0 Nov 28 20:57 cpuset.mems.effective
-r--r--r--  1 root root 0 Nov 28 20:52 cpu.stat
-rw-r--r--  1 root root 0 Nov 28 20:57 cpu.uclamp.max
-rw-r--r--  1 root root 0 Nov 28 20:57 cpu.uclamp.min
-rw-r--r--  1 root root 0 Nov 28 20:52 cpu.weight
-rw-r--r--  1 root root 0 Nov 28 20:57 cpu.weight.nice
-rw-r--r--  1 root root 0 Nov 28 20:52 io.bfq.weight
-rw-r--r--  1 root root 0 Nov 28 20:57 io.latency
-rw-r--r--  1 root root 0 Nov 28 20:57 io.low
-rw-r--r--  1 root root 0 Nov 28 20:57 io.max
-rw-r--r--  1 root root 0 Nov 28 20:57 io.pressure
-rw-r--r--  1 root root 0 Nov 28 20:57 io.prio.class
-r--r--r--  1 root root 0 Nov 28 20:52 io.stat
-rw-r--r--  1 root root 0 Nov 28 20:52 io.weight
-r--r--r--  1 root root 0 Nov 28 20:54 memory.current
-r--r--r--  1 root root 0 Nov 28 20:52 memory.events
-r--r--r--  1 root root 0 Nov 28 20:54 memory.events.local
-rw-r--r--  1 root root 0 Nov 28 20:52 memory.high
-rw-r--r--  1 root root 0 Nov 28 20:52 memory.low
-rw-r--r--  1 root root 0 Nov 28 20:52 memory.max
-rw-r--r--  1 root root 0 Nov 28 20:52 memory.min
-r--r--r--  1 root root 0 Nov 28 20:54 memory.numa_stat
-rw-r--r--  1 root root 0 Nov 28 20:52 memory.oom.group
-r--r--r--  1 root root 0 Nov 28 20:54 memory.peak
-rw-r--r--  1 root root 0 Nov 28 20:54 memory.pressure
--w-------  1 root root 0 Nov 28 20:54 memory.reclaim
-r--r--r--  1 root root 0 Nov 28 20:54 memory.stat
-r--r--r--  1 root root 0 Nov 28 20:54 memory.swap.current
-r--r--r--  1 root root 0 Nov 28 20:54 memory.swap.events
-rw-r--r--  1 root root 0 Nov 28 20:54 memory.swap.high
-rw-r--r--  1 root root 0 Nov 28 20:52 memory.swap.max
-r--r--r--  1 root root 0 Nov 28 20:54 memory.zswap.current
-rw-r--r--  1 root root 0 Nov 28 20:54 memory.zswap.max
-r--r--r--  1 root root 0 Nov 28 20:57 pids.current
-r--r--r--  1 root root 0 Nov 28 20:57 pids.events
-rw-r--r--  1 root root 0 Nov 28 20:52 pids.max
```

</p></details>


### Memory usage of group

```
$ cat /sys/fs/cgroup/"$(awk -F : '{ print $3 }' < /proc/740/cgroup)"/memory.current
102809600
```
