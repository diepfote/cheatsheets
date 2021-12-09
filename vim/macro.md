# Macros

## run macro across multiple lines
 -> snatched form https://stackoverflow.com/a/390194

```
:5,10 normal! @a
```

Execute the macro stored in register a on lines 5 through the end of the file.

```
:5,$ normal! @a
```

Execute the macro stored in register a on all lines.

```
:% normal! @a
```

Execute the macro store in register a on all lines matching pattern.

```
:g/pattern/ normal! @a
```

To execute the macro on visually selected lines, press V and the j or k until the desired region is selected. Then type :normal! @a and observe the that following input line is shown.

```
:'<,'> normal! @a
```
