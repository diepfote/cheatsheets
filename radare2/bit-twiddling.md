# Bit Twiddling

## Flip Endianness - convert little endian to big endian

This examples assumes a hex address, hence `=16`

In radare:

```text
[0x5632901196b0]> !rax2 =16 -e 0xd0066fda4e560000
0x564eda6f06d0
```

In your shell:

```
rax2 =16 -e 0xd0066fda4e560000
0x564eda6f06d0
```

## change bases

base 16 to base 10 - hex to decimal

```
$ rax2 30
0x1e
```

base 10 to base 16 - decimal to hex

```
$ rax2 =10 0x1e
30
```

*NOTE*: `=xx` uses `rax2`'s forced output mode.

    From the man page:

             =f    floating point
             =2    binary
             =3    ternary
             =8    octal
             =10   decimal
             =16   hexadecimal



*NOTE*: `rax2` can also convert from a binary string to a number or 
        hex string to character an vice versa.
