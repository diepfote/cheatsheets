# Radare2 | Radare 2

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

## Print hex value of character

```
$ rax2 -S J
4a

man rax2
```

## Print hex string as string

```
$ rax2 -s 0x0000006c
l
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

**Sidenote**: gdb shows that it cannot read memory, radare2 implicitly maps it to 0xff
```
gef➤  x/s $edx
0xc:    <error: Cannot access memory at address 0xc>
gef➤  x/x $edx
0xc:    Cannot access memory at address 0xc
gef➤  print $edx
$1 = 0xc
```

## run debugger with arguments

### start-up radare2 debugger with arguments

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

## print variables / print vars

https://book.rada.re/analysis/variables.html

### radare helpers in functions - example

```
[0x55a216e282ec]> afvf
0x00000024  var_1ch:   int64_t
0x00000020  var_18h:   int64_t
0x00000010  var_8h:    int64_t
0xffffffffffffffee  arg2:      int64_t
0xfffffffffffffff2  arg1:      int64_t
[0x55a216e282ec]> afvd var_18h
pf q @rbp-0x18
[0x55a216e282ec]> afvd var_8h
pf q @rbp-0x8
[0x55a216e282ec]> afvd arg1
pf r (rdi)
[0x55a216e282ec]> x/s @rdi
0x7ffecd9b3fb9 ex17.db.dat
0x7ffecd9b3fc4 l
0x7ffecd9b3fc6 /Users/florian.begusch/Desktop/c-exercises/a.out
[0x55a216e282ec]> ps @rdi
ex17.db.dat
[0x55a216e282ec]> afvd arg2
pf r (rsi)
[0x55a216e282ec]> ps @rsi
\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff
[0x55a216e282ec]> px 1 @rsi
- offset -  6C6D 6E6F 7071 7273 7475 7677 7879 7A7B  CDEF0123456789AB
0x0000006c  ff                                       .
[0x55a216e282ec]> px 1 @rdi
- offset -      B9BA BBBC BDBE BFC0 C1C2 C3C4 C5C6 C7C8  9ABCDEF012345678
0x7ffecd9b3fb9  65                                       e
[0x55a216e282ec]> afvd arg1
pf r (rdi)
[0x55a216e282ec]> pf r (rdi)
  : rdi : 0x7ffecd9b3fb9
[0x55a216e282ec]> px 1 @ 0x7ffecd9b3fb9
- offset -      B9BA BBBC BDBE BFC0 C1C2 C3C4 C5C6 C7C8  9ABCDEF012345678
0x7ffecd9b3fb9  65                                       e

# ah this is actually a hardcoded character literal, no resolvable `rax2 -s 0x0000006c`
[0x55a216e282ec]> pf r (rsi)
  : rsi : 0x0000006c

```


### example - print memory locations

Show function arguments before entering function

```
[0x558cc804b852]> pd -10 @ rip
            0x558cc804b830 00:0000      488945f0       mov qword [rbp - 0x10], rax
            0x558cc804b834 00:0000      488b45d0       mov rax, qword [rbp - 0x30] ; rax=0x7ffec4c8c2f8 (pstr 0x7ffec4c8dfda) "./a.out" rbx
            0x558cc804b838 00:0000      4883c010       add rax, 0x10   ; 16 ; rax=0x7ffec4c8c308 (pstr 0x7ffec4c8dfee) "l" ; of=0x0 ; sf=0x0 ; zf=0x0 ; cf=0x0 ; pf=0x0 ; af=0x0
            0x558cc804b83c 00:0000      488b00         mov rax, qword [rax] ; rax=0x7ffec4c8dfee
            0x558cc804b83f 00:0000      0fb600         movzx eax, byte [rax] ; rax=0x6c rsi
            0x558cc804b842 00:0000      8845eb         mov byte [rbp - 0x15], al
            0x558cc804b845 00:0000      0fbe55eb       movsx edx, byte [rbp - 0x15] ; rdx=0x6c rsi
            0x558cc804b849 00:0000      488b45f0       mov rax, qword [rbp - 0x10] ; rax=0x7ffec4c8dfe2 rdi
            0x558cc804b84d 00:0000      89d6           mov esi, edx    ; rsi=0x6c rsi
            0x558cc804b84f 00:0000      4889c7         mov rdi, rax    ; rdi=0x7ffec4c8dfe2
[0x558cc804b852]> pd 3 @ rip
            ;-- rip:
            0x558cc804b852 00:0000      e895faffff     call sym.Database_open ; rsp=0x7ffec4c8c1a8 ; rip=0x558cc804b2ec ; sym.Database_open(0x7ffec4c8dfe2, 0x6c, 0x6c, 0x558cc804ddd8)
            0x558cc804b857 00:0000      488945f8       mov qword [rbp - 8], rax
            0x558cc804b85b 00:0000      c745ec000000.  mov dword [rbp - 0x14], 0

# print all argv
[0x558cc804b852]> ps 30 @ [ rbp - 0x10 ]
ex17.db.dat\x00l\x00./a.out\x00\x00\x00\x00\x00\x00\x00\x00\x00
# same as rdi if you take a look at the assembly above 
# null terminated after `...dat`, so arg is `ex17.db.dat`
[0x558cc804b852]> ps 30 @ rdi
ex17.db.dat\x00l\x00./a.out\x00\x00\x00\x00\x00\x00\x00\x00\x00

# second arg `mode` to `Database_open` is just a character literal. what is its value?
# check the memory location -> 0x6c -> character `l`
[0x558cc804b852]> px 1 @ rdx
- offset -  6C6D 6E6F 7071 7273 7475 7677 7879 7A7B  CDEF0123456789AB
0x0000006c  ff
$ rax2 -s 0x0000006c
l
```
