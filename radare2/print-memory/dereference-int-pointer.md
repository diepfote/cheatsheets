# Dereference int pointer

## Setup

`update_integer` does not do anything with its argument but it returns
a pointer to a static integer in the function.

`integer_ptr` is initialized with `1`. We want to see it change to `30`/`0x1e`.

```text
int* update_integer(int new_int) {

	static int integer = 1;

	return &integer;
}

int* integer_ptr = update_integer(20);
*integer_ptr = 30;
```

<details><summary>Setup</summary><p>

```text
[0x7f4fffa2f2a0]> pd 1200 @ main | grep -C 5 update_integer
            0x00201e48 00:0000      40             invalid
            0x00201e49 00:0000      16             invalid
            0x00201e4a 00:0000      488b4588       mov rax, qword [rbp - 0x78] ; ex22_main.c:0 ; rax=0xffffffffffffffff
            0x00201e4e 00:0000      f20f1005e2e6.  movsd xmm0, qword [0x00200538] ; ex22_main.c:62     *ratio_ptr = 123123123.0; ; [0x200538:8]=0x419d5ad6cc000000
            0x00201e56 00:0000      f20f1100       movsd qword [rax], xmm0
            0x00201e5a 00:0000      bf14000000     mov edi, 0x14       ; ex22_main.c:64     int* integer_ptr = update_integer(20); ; 20 ; rdi=0x14
            0x00201e5f 00:0000      e85cfbffff     call sym.update_integer ; rsp=0x7ffe469ccef8 ; rip=0x2019c0 ; sym.update_integer(0x0, 0x0, 0x0, 0x0)
            0x00201e64 00:0000      488945e0       mov qword [rbp - 0x20], rax
            0x00201e68 00:0000      488b4de0       mov rcx, qword [rbp - 0x20] ; ex22_main.c:65     *integer_ptr = 30; ; rcx=0xffffffffffffffff
            0x00201e6c 00:0000      48894d80       mov qword [rbp - 0x80], rcx
            0x00201e70 00:0000      4883f900       cmp rcx, 0          ; zf=0x0 ; cf=0x0 ; pf=0x1 ; sf=0x1 ; of=0x0 ; af=0x0
            0x00201e74 00:0000      0f95c0         setne al            ; al=0x1
[0x7f4fffa2f2a0]> dcu 0x00201e68
INFO: Continue until 0x00201e68 using 1 bpsize
[INFO] (ex22_main.c:34:main()) My name: A Name, age: 37
[INFO] (ex22_main.c:41:main()) My age is now: 100
[INFO] (ex22_main.c:42:main()) My age is now: 123
[INFO] (ex22_main.c:46:main()) THE_SIZE is: 1000
[INFO] (ex22.c:33:print_size()) I think size is: 1000
[INFO] (ex22_main.c:51:main()) THE_SIZE is now: 9
[INFO] (ex22.c:33:print_size()) I think size is: 9
[INFO] (ex22_main.c:55:main()) Ratio at first: 1.000000
[INFO] (ex22_main.c:57:main()) Ratio again: 1.000000
[INFO] (ex22_main.c:58:main()) Ratio once more: 1.000000
INFO: hit breakpoint at: 0x201e68
[0x00201e68]> pd 20
            ;-- rip:
            0x00201e68 00:0000      488b4de0       mov rcx, qword [rbp - 0x20] ; ex22_main.c:65     *integer_ptr = 30; ; rcx=0x2041d8 rax
            0x00201e6c 00:0000      48894d80       mov qword [rbp - 0x80], rcx
            0x00201e70 00:0000      4883f900       cmp rcx, 0          ; zf=0x0 ; cf=0x0 ; pf=0x1 ; sf=0x0 ; of=0x0 ; af=0x0
            0x00201e74 00:0000      0f95c0         setne al            ; al=0x1 rcx
            0x00201e77 00:0000      4883e103       and rcx, 3          ; rcx=0x0 ; zf=0x1 ; pf=0x1 ; sf=0x0 ; cf=0x0 ; of=0x0
            0x00201e7b 00:0000      4883f900       cmp rcx, 0          ; zf=0x1 ; cf=0x0 ; pf=0x1 ; sf=0x0 ; of=0x0 ; af=0x0
            0x00201e7f 00:0000      0f94c1         sete cl             ; cl=0x1 rcx
            0x00201e82 00:0000      20c8           and al, cl          ; al=0x1 rcx ; zf=0x0 ; pf=0x0 ; sf=0x0 ; cf=0x0 ; of=0x0
            0x00201e84 00:0000      a801           test al, 1          ; rcx ; zf=0x0 ; pf=0x0 ; sf=0x0 ; cf=0x0 ; of=0x0
        ┌─< 0x00201e86 00:0000      0f8505000000   jne 0x201e91        ; rip=0x201e91 ; likely
        │   0x00201e8c 00:0000      670fb9         ud2b
        │   0x00201e8f 00:0000      40             invalid
        │   0x00201e90 00:0000      16             invalid
        └─> 0x00201e91 00:0000      488b4580       mov rax, qword [rbp - 0x80] ; ex22_main.c:0 ; rax=0x0
            0x00201e95 00:0000      c7001e000000   mov dword [rax], 0x1e ; ex22_main.c:65     *integer_ptr = 30; ; [0x1e:4]=-1 ; 30
            0x00201e9b 00:0000      488b05fe1200.  mov rax, qword [reloc.stderr] ; ex22_main.c:68     log_info("Ratio at the end: %f", *update_ratio(300.0)); ; [0x2031a0:8]=0x7f4fff9eb6a0 ; rax=0x7f4fff9eb6a0 -> 0xfbad2887
            0x00201ea2 00:0000      488b00         mov rax, qword [rax] ; rax=0x7f4fff9eb4e0
            0x00201ea5 00:0000      48898570ffff.  mov qword [rbp - 0x90], rax
            0x00201eac 00:0000      f20f10057ce6.  movsd xmm0, qword [0x00200530] ; [0x200530:8]=0x4072c00000000000
            0x00201eb4 00:0000      e817fbffff     call sym.update_ratio ; rsp=0x7ffe469cce38 -> 0xe0458948 ; rip=0x2019d0 ; sym.update_ratio(0x14, 0x7ffe469ccc90, 0x0, 0x1)
[0x00201e68]> dcu 0x00201e9b
INFO: Continue until 0x00201e9b using 1 bpsize
INFO: hit breakpoint at: 0x201e9b
```

</p></details>

*Note*:
This is how a register is used to refer to a memory location (taken from above):

```text
        └─> 0x00201e91 00:0000      488b4580       mov rax, qword [rbp - 0x80] ; ex22_main.c:0 ; rax=0x0
            0x00201e95 00:0000      c7001e000000   mov dword [rax], 0x1e ; ex22_main.c:65     *integer_ptr = 30; ; [0x1e:4]=-1 ; 30
```

## Dereference

```text
[0x00201e9b]> # show the current value for the rbp register
[0x00201e9b]> dr rbp
0x7ffe469ccee0
[0x00201e9b]> pxq 4 @ rbp-0x80
0x7ffe469cce60  0x00000000002041d8                       .A .
[0x00201e9b]> pxq 4 @ 0x7ffe469ccee0-0x80
0x7ffe469cce60  0x00000000002041d8                       .A .
[0x00201e9b]> pxq 4 @ [0x7ffe469ccee0-0x80]
0x002041d8  0x000000000000001e                       ....
[0x00201e9b]>
```

