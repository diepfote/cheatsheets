# Radare2 | Radare 2

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

## Debugger Continue / Debugger Stepping

``` 
# single step instruction
ds

# step 10 instructions
ds 10

# step over instruction (treat function calls as instructions) 
dso

# step until address
dsu <address>

# continue until function start
dcu <func-address>/<func-name>

# continue until next breakpoint
dc
```

## print registers

### show general purpose registers

`dr`

### show registers related to conditionals

`drc` ... for more information `dr?`

## print variables / print vars

https://book.rada.re/analysis/variables.html

### radare helpers in functions - example

<details><summary></summary><p>

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

</p></details>
