# Radare analyze coredumps

## Load coredump

```
$ r2 -d a.out /tmp/coredump
WARN: Cannot resolve symbol address __libc_start_main
WARN: Cannot resolve symbol address __gmon_start__
[0x7f8c4dc482a0]> dbt
0  0x7f8c4dc482a0     sp: 0x0                 0    [??]  rip map._usr_lib_ld_linux_x86_64.so.2.r_x+107168
```

