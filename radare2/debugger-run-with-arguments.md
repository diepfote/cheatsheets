# run debugger with arguments

### start-up radare2 debugger with arguments

snatched from <https://stackoverflow.com/questions/39487888/radare2-how-to-pass-parameters-to-debugee/41515545#41515545>

Hint: run `ood` if radare was not started in debug mode

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
$ cat ./ex17.profile
#!/usr/bin/rarun2
program=./a.out
arg1=ex17.db.dat
arg2=l

$ r2 -r ex17.profile -d a.out
[0x7fa545112730]> dcu main
INFO: Continue until 0x5637c4ab7804 using 1 bpsize
hit breakpoint at: 0x5637c4ab7804
```
