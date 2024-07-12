# Bash escapes

## Bash how to escape a single quote in a single quoted string

### Here is how not to do it:

```text
$ echo 'Don\'t do it'
>
 
```

### Here is how to do it

```text
$ echo 'Don'"'"'t do it'
Don't do it
```

These amount to not one but several strings, so my title is wrong.

1st string: `Don`  
2nd: `"'"` which outputs `'`  
3rd string: `t do it`
