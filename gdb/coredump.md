# GDB analyze coredumps

## Export core file

```sh
coredumpctl list
coredumpctl dump --output /tmp/coredump 71155
```

## Show full stack trace

```sh
gdb a.out -c /tmp/coredump

(gdb) bt full
#0  0x0000000000000000 in ?? ()
No symbol table info available.
#1  0x0000000000201edf in test_sorting (numbers=0x1a422a0, count=5, sort=0x0,
    cmp=0x201e10 <reverse_order>) at ex18.c:99
        idx = 0
        sorted = 0x1a422c0
        data = 0x201e10 <reverse_order> "UH\211\345\211}\374\211u\370\213E\370+E\374\211E\364\017\220\3004\377\250\001\017\205\005"
#2  0x00000000002022da in main (argc=6, argv=0x7ffc60229ec8) at ex18.c:139
        count = 5
        idx = 5
        inputs = 0x7ffc60229ed0
        numbers = 0x1a422a0
(gdb) up 1
#1  0x0000000000201edf in test_sorting (numbers=0x1a422a0, count=5, sort=0x0,
    cmp=0x201e10 <reverse_order>) at ex18.c:99
99              int *sorted = sort(numbers, count, cmp);
(gdb) up 1
#2  0x00000000002022da in main (argc=6, argv=0x7ffc60229ec8) at ex18.c:139
139             test_sorting(numbers, count, NULL, reverse_order);
```

More at:  
<https://stackoverflow.com/a/8306805>  
<https://stackoverflow.com/a/22711917>  
[Examining the symbol table](https://sourceware.org/gdb/current/onlinedocs/gdb.html/Symbols.html)
