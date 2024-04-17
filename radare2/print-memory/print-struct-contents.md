# Print struct contents (argument to func call)

C struct to print  -> Database\* (FILE\* ... address of FILE -> 8 byte address -> rdi+8)

```text
struct Connection {
        FILE *file;
        struct Database *db;
};

void Database_load(struct Connection *conn) {
}
```


```text
$ r2 -r ex17.profile -d a.out
[0x5632901196b0]> px 8 @ rdi   # FILE*
- offset -      B0B1 B2B3 B4B5 B6B7 B8B9 BABB BCBD BEBF  0123456789ABCDEF
0x564eda6f06b0  009a 70da 4e56 0000                      ..p.NV..
[0x5632901196b0]> px 8 @ rdi+8   # Database*
- offset -      B8B9 BABB BCBD BEBF C0C1 C2C3 C4C5 C6C7  89ABCDEF01234567
0x564eda6f06b8  d006 6fda 4e56 0000                      ..o.NV..
[0x5632901196b0]> px 16 @ rdi
- offset -      B0B1 B2B3 B4B5 B6B7 B8B9 BABB BCBD BEBF  0123456789ABCDEF
0x564eda6f06b0  009a 70da 4e56 0000 d006 6fda 4e56 0000  ..p.NV....o.NV..

[0x5632901196b0]> # flip endianness of memory address
[0x5632901196b0]> !rax2 =16 -e 0xd0066fda4e560000
0x564eda6f06d0

[0x5632901196b0]> # Database contents
[0x5632901196b0]> px 20 @ 0x564eda6f06d0
- offset -      D0D1 D2D3 D4D5 D6D7 D8D9 DADB DCDD DEDF  0123456789ABCDEF
0x564eda6f06d0  0000 0000 0000 0000 0000 0000 0000 0000  ................
0x564eda6f06e0  0000 0000                                ....
```
