# Rizin

## JSON output
Append `j` or `j~{}` for json or json+intended output

```
izj
izj~{}
```

## Quiet output

Append `q`


## Interal grep `~`

```
iz~string
```

## Print integer value of character

```
$ rz-ax -S J
4a

man rz-ax
```

## Temporary seek

Do this

```
pd @0x1234
```

instead of

```
s 0x1234
pd 32
```

## Disable emulation

Run native code instead of VM

```
e asm.emu=false
```

## Print memory address of printf call (which is actually just an int)


```
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

**Sidenote**: gdb shows that it cannot read memory, rizin implicitly maps it to 0xff
```
gef➤  x/s $edx
0xc:    <error: Cannot access memory at address 0xc>
gef➤  x/x $edx
0xc:    Cannot access memory at address 0xc
gef➤  print $edx
$1 = 0xc
```

## run debugger with arguments

### start-up rizin debugger with arguments

snatched from <https://stackoverflow.com/questions/39487888/radare2-how-to-pass-parameters-to-debugee/41515545#41515545>

```
$ r2 -d a.out ex17.db.dat l
[0x7f4161daa8a1]> ood
PTRACE_CONT: No such process
child received signal 9
INFO: File dbg:///home/flo/Desktop/c-exercises/a.out reopened in read-write mode
[0x7f1498268730]> dcu main
INFO: Continue until 0x557877e50804 using 1 bpsize
hit breakpoint at: 0x557877e50804
```

or 

```
$ cat ./ex17.r
#!/usr/bin/rarun2
arg1=ex17.db.dat
arg2=l

$ r2 -r ex17.r -d a.out
[0x7f07ee4c7730]> ood
child received signal 9
[0x7fa545112730]> dcu main
INFO: Continue until 0x5637c4ab7804 using 1 bpsize
hit breakpoint at: 0x5637c4ab7804
```


## print registers

### show general purpose registers

`dr`

### show registers related to conditionals

`drc` ... for more information `dr?`

## print variables

https://book.rizin.re/analysis/variables.html

### TODO
