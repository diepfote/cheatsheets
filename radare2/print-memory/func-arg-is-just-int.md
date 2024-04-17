# Print `printf` argument if it is just an INT


```text
................> pd 50 @ main 
...
            0x5585e1d801f1 00:0000      mov   edx, dword [rbp - 0x2c]
            0x5585e1d801f4 00:0000      mov   eax, dword [rbp - 0x30]
            0x5585e1d801f7 00:0000      mov   esi, eax
            0x5585e1d801f9 00:0000 b    lea   rax, str.The_first_area_is__d__the_2nd__d. ; 0x5585e1d81070 ; "The first area is %d, the 2nd %d.\n"
            0x5585e1d80200 00:0000      mov   rdi, rax
            0x5585e1d80203 00:0000      mov   eax, 0
            0x5585e1d80208 00:0000      call  sym.imp.printf
...


[0x7f8399f08730]> db @ 0x5585e1d801f1
[0x7f8399f08730]> dc
[+] SIGNAL 28 errno=0 addr=0x00000000 code=128 si_pid=0 ret=0
[0x7f8399f08730]> dc
The size of an int: 4
The size of areas (int[]): 20
The number of ints in areas: 5
hit breakpoint at: 0x5585e1d801f1
[0x5585e1d801f1]> pd 2
            ;-- rip:
            0x5585e1d801f1 00:0000 b    mov   edx, dword [rbp - 0x2c]
            0x5585e1d801f4 00:0000      mov   eax, dword [rbp - 0x30]
[0x5585e1d801f1]> ds
[0x5585e1d801f1]> pfb  @ edx
0x0000000c = 0xff
[0x5585e1d801f1]> pfb  @ [rbp-0x2c]
0xd0000000c = 0xff
[0x5585e1d801f1]>

$ qalc 0xc
12 = 12
```

**Sidenote**: gdb shows that it cannot read memory, radare2 implicitly maps it to 0xff

```text
gef➤  x/s $edx
0xc:    <error: Cannot access memory at address 0xc>
gef➤  x/x $edx
0xc:    Cannot access memory at address 0xc
gef➤  print $edx
$1 = 0xc
```

