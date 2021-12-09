-----------
### calculate a relocatable offset

-> instructions
0x109a: lea     rcx, [rip + 0x1af]
0x10a1: lea     rdi, [rip + 0xd1]
0x10a8: call    qword ptr [rip + 0x2f32]
0x10ae: hlt
0x10af: nop

-> relocation entries
%s: .rela.dyn
        0x3de8
        0x3df0
        0x4048
_ITM_deregisterTMCloneTable     0x3fd8
__libc_start_main       0x3fe0
__gmon_start__  0x3fe8
_ITM_registerTMCloneTable       0x3ff0
__cxa_finalize  0x3ff8
stdin   0x4050
%s: .rela.plt
puts    0x4018
printf  0x4020
fgets   0x4028
strcmp  0x4030
malloc  0x4038


as soon as the processor executes the next instruction the instruction pointer points to the next instruction in line...
0x10a8: call    qword ptr [rip + 0x2f32]
0x10ae: hlt

Thus [rip + 0x2f32] is equvivalent to [0x10ae + 0x2f32] which evaluates to 0x3fe0
-----------




https://medium.com/sector443/python-for-reverse-engineering-1-elf-binaries-e31e92c33732
.got -> Global Offset Table
.ptl -> Procedure Linkage Table # https://stackoverflow.com/a/5469334
system@plt --> variable address for system syscall

-----------
### 32 bit register layout
+---------+------+------+------+------+------+------+------+------+
| syscall | arg0 | arg1 | arg2 | arg3 | arg4 | arg5 |      |      |
+---------+------+------+------+------+------+------+------+------+
|   %eax  | %ebx | %ecx | %edx | %esi | %edi | %ebp | %eip | %esp |
+---------+------+------+------+------+------+------+------+------+
-----------

-----------
### 64 bit register layout
+---------+------+------+------+------+------+------+
| syscall | arg0 | arg1 | arg2 | arg3 | arg4 | arg5 |
+---------+------+------+------+------+------+------+
|   %rax  | %rdi | %rsi | %rdx | %r10 | %r8  | %r9  |
+---------+------+------+------+------+------+------+

%rbp - %rip  - %rsp
  8  -   8  -  8


For 64 bit, the argument needs to be passed into CPU register instead of the stack. (https://arvandy.com/rop-emporium-split/)


+-----------+
FROM https://gist.github.com/justinian/385c70347db8aca7ba93e87db90fc9a6#file-linux-x64-nasm-cheatsheet-md
# x64 NASM cheat sheet

## Registers

|                         | 64 bit | 32 bit | 16 bit | 8 bit |
|-------------------------|--------|--------|--------|-------|
| A (accumulator)         | `RAX`  | `EAX`  | `AX`   | `AL`  |
| B (base, addressing)    | `RBX`  | `EBX`  | `BX`   | `BL`  |
| C (counter, iterations) | `RCX`  | `ECX`  | `CX`   | `CL`  |
| D (data)                | `RDX`  | `EDX`  | `DX`   | `DL`  |
|                         | `RDI`  | `EDI`  | `DI`   | `DIL` |
|                         | `RSI`  | `ESI`  | `SI`   | `SIL` |
| Numbered (n=8..15)      | `Rn`   | `RnD`  | `RnW`  | `RnB` |
| Stack pointer           | `RSP`  | `ESP`  | `SP`   | `SPL` |
| Frame pointer           | `RBP`  | `EBP`  | `BP`   | `BPL` |

As well as XMM0 .. XMM15 for 128 bit floating point numbers.


## Calling Conventions

Put function arguments (first to last) in the following registers (64 bit
representations): RDI, RSI, RDX, RCX, R8, R9, then push to stack (in reverse,
has to be cleaned up by the caller!) XMM0 - XMM7 for floats

Return values are stored in RAX (`int`) or XMM0 (`float`)

RBP, RBX, R12, R13, R14, R15 will not be changed by the called function, all
others may be

Align stack pointer (RSP) to 16 byte, calling pushes 8 bytes!

Keep in mind that strings (in C) are 0-terminated

Like in a normal C program, the label that is (de facto) called first is
`main`, with the args `argc` (argcount) in RDI, and the `char** argv` in RSI
(the commandline arguments as in C's main function).

+-----------+

