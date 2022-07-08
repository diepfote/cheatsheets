# Docker containers

## container defaults

$ podman run --security-opt=no-new-privileges \
             --rm \
             ...

*or even*

$ podman run --security-opt=no-new-privileges \
             --cap-drop=ALL \
             --rm \
             ...


## run a container with custom entrypoint
 | run a container with custom cmd
 | run a container with custom command
 | run a container with command

$ podman run --security-opt=no-new-privileges \
             --cap-drop=ALL \
             --rm \
             --entrypoint=bash \
             -v (realpath ../qiime2_wrappers/qiime2/):/qiime2 \
             -it \
             --name planemo-instance \
             bgruening/planemo


## show namespace information (UTS, IPC, CGROUP, ...)

```
docker ps --ns
```

## show cpu stats per process/per container

```
# per second cpu stats per process
$ pidstat 1
Linux 5.18.7-arch1-1 (lima-default)     07/07/2022      _x86_64_        (4 CPU)

08:55:58 AM   UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
08:55:59 AM     0        16    0.00    0.99    0.00    0.00    0.99     0  rcu_preempt
08:55:59 AM     0      1371    0.00    4.95    0.00    0.00    4.95     1  kworker/u8:2-events_freezable_power_
08:55:59 AM     0      1474    0.00   31.68    0.00    0.00   31.68     1  kworker/u8:11-btrfs-delalloc
08:55:59 AM     0      1475    0.00   23.76    0.00    0.00   23.76     2  kworker/u8:12-btrfs-delalloc
08:55:59 AM   501      2685    0.00    0.99    0.00    0.00    0.99     1  podman
08:55:59 AM   501      2706   15.84   54.46    0.00    4.95   70.30     3  bash
08:55:59 AM   501      2826    0.00    0.99    0.00    0.00    0.99     0  pidstat

08:55:59 AM   UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
08:56:00 AM     0      1474    0.00   13.00    0.00    0.00   13.00     1  kworker/u8:11-btrfs-delalloc
08:56:00 AM     0      1475    0.00   49.00    0.00    0.00   49.00     3  kworker/u8:12-btrfs-delalloc
08:56:00 AM   501      2685    0.00    1.00    0.00    0.00    1.00     1  podman
08:56:00 AM   501      2706   13.00   54.00    0.00    6.00   67.00     2  bash
08:56:00 AM   501      2826    0.00    1.00    0.00    0.00    1.00     0  pidsta

$ podman ps --ns
CONTAINER ID  NAMES            PID         CGROUPNS    IPC         MNT         NET         PIDNS       USERNS      UTS
0e07e6b36426  quizzical_elion  1484        4026532378  4026532376  4026532373  4026532305  4026532377  4026532303  4026532375

# per second cpu stats for pid 1484
$ pidstat 1 -p 1484
Linux 5.18.7-arch1-1 (lima-default)     07/07/2022      _x86_64_        (4 CPU)


08:45:32 AM   UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
08:45:33 AM   501      1484    3.96    3.96    0.00    0.00    7.92     1  bash
08:45:34 AM   501      1484    5.00    2.00    0.00    1.00    7.00     0  bash
```

## container I/O | container IO

```
# per second iostats for processes/containers
$ pidstat -d 1
Linux 5.18.7-arch1-1 (lima-default)     07/07/2022      _x86_64_        (4 CPU)

08:54:44 AM   UID       PID   kB_rd/s   kB_wr/s kB_ccwr/s iodelay  Command
08:54:45 AM   501      2706      0.00   8498.04      0.00       0  bash

08:54:45 AM   UID       PID   kB_rd/s   kB_wr/s kB_ccwr/s iodelay  Command
08:54:46 AM   501      2706      0.00   8440.00      0.00       0  bash

# per second iostats for pid
$ pidstat -p 2706 -d 1
Linux 5.18.7-arch1-1 (lima-default)     07/07/2022      _x86_64_        (4 CPU)

08:55:09 AM   UID       PID   kB_rd/s   kB_wr/s kB_ccwr/s iodelay  Command
08:55:10 AM   501      2706      0.00   8463.37      0.00       0  bash
08:55:11 AM   501      2706      0.00   8684.00      0.00       0  bash
08:55:12 AM   501      2706      0.00   8668.00      0.00       0  bash
08:55:13 AM   501      2706      0.00   8564.00      0.00       0  bash
08:55:14 AM   501      2706      0.00   8768.00      0.00       0  bash
```

## `top` for docker containers

```
docker stats
```

## `top` for cgroups

```
systemd-cgtop
```
