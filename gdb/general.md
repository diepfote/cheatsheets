# GDB

## use defines
```
# either
gdb -ex gef -q

# or
gdb -ex pwndbg -q
```

## unset LESSSECURE in current bash process
```
export LESSSECURE=1
read-only LESSSECURE

unset-readonly-var () {
cat << EOF | sudo gdb -q
attach $$
call (void)unbind_variable("$1")
detach
EOF
}


VARIABLE_TO_UNSET=LESSSECURE
unset-readonly-var "$VARIABLE_TO_UNSET"
```


## memory & registers
```
# info about a register
i r <reg_name>
info register <reg_name>
# for all registers run
i r




## displaying memory
# -> run examine
x

# examine for a specific register
x $rbp

# memory display options
# formats:
o Display in octal.
x Display in hexadecimal.
u Display in unsigned, standard base-10 decimal.
t Display in binary.

# valid sizes:
b A single byte
h A halfword, which is two bytes in size
w A word, which is four bytes in size
g A giant, which is eight bytes in size valid sizes:

# e.g.:
x/4xw $rbp # display 4 chunks as words in hexadecimal format
```

### dereference stack pointer to string

```
gdb-peda$ stack
0000| 0xffffd340 --> 0x2
0004| 0xffffd344 --> 0xffffd515 ("/home/flo/Documents/asm/check_is_pdf")
0008| 0xffffd348 --> 0xffffd53a ("test.s")
0012| 0xffffd34c --> 0x0
0016| 0xffffd350 --> 0xffffd541 ("BLUE=\033[34m")
0020| 0xffffd354 --> 0xffffd54c ("BOLD=\033[1m")
0024| 0xffffd358 --> 0xffffd556 ("COLUMNS=239")
0028| 0xffffd35c --> 0xffffd562 ("DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus")
gdb-peda$ x/s *((char **) (8 + $ebp))
0xffffd53a:     "test.s"
```

