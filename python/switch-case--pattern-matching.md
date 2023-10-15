# Pattern matching - Switch case

`/tmp/asdf.py`:

```
import sys

match sys.argv[1]:
    case "asdf":
        print("asdf")
    case "123":
        print("123")
    case _:
        print(sys.argv[1])
```


`Note`: There is no implicit fall through:

```
$ python /tmp/asdf.py  123
123

$ python /tmp/asdf.py  asdf
asdf

$ python /tmp/asdf.py  sdfa
sdfa
```
