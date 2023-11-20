# Endianness

## Flip Endianness - convert little endian to big endian

This examples assumes a hex address, hence `=16`

In radare:

```
[0x5632901196b0]> !rax2 =16 -e 0xd0066fda4e560000
0x564eda6f06d0
```

In your shell:

```
rax2 =16 -e 0xd0066fda4e560000
0x564eda6f06d0
```
