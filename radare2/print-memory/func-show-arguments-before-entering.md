# Show function arguments before entering function

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


[0x558cc804b852]> # print all argv
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
