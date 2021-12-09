# Sed

## Substitude

* replace n-th occurrence of a pattern

```
$ echo 'otherotherotherother' | sed 's#other#()#2'
other()otherother
```

* multi-line replacement

use backslashes to indicate input continues (new lines).

```

echo '.Ah "Major Heading"' | sed '
/^\.Ah/{
s#\.Ah *#\
\
@A HEAD = #
s/"//g
s/$/\
/
}'


## Insert

inserted content will not be affected by subsequent commands

```
$ echo -e 'something\nother bli bla blub\n\n\nasdf' \
| sed -r '/other/i\
4700 Cross Court\
French Lick, IN

s#French#NOT IT#
s#other#OTHER#
'
something
4700 Cross Court
French Lick, IN
OTHER bli bla blub


asdf
```

## Append

appended content will not be affected by subsequent commands

```
$ echo -e 'something\nother bli bla blub\n\n\nasdf' \
| sed -r '/other/a\
4700 Cross Court\
French Lick, IN

s#French#NOT IT#
s#other#OTHER#
'
something
OTHER bli bla blub
4700 Cross Court
French Lick, IN


asdf
```

## Change

The change command replaces the contents of the pattern space with the text you provide.
In effect, it deletes the current line and puts the supplied text in its place.
It can be used when you want to match a line and replace it entirely.


```
$ echo -e 'something\nother bli bla blub\n\n\nasdf' \
| sed -r '/other/c\
4700 Cross Court\
French Lick, IN

s#French#NOT IT#
s#other#OTHER#
'
something
4700 Cross Court
French Lick, IN


asdf
```


## List

The list command (l) displays the contents of the pattern space, showing non-
printing characters as two-digit ASCII codes.

## Transform

Think of it as translate char to char.

```
$ echo -e 'something\nother bli bla blub\n\n\nasdf' | sed 'y/abc/xyz/'
something
other yli ylx yluy


xsdf
```

## Print

The print command (p) causes the contents of the pattern space to be output.
It does not clear the pattern space nor does it change the flow of control in the script.
However, it is frequently used before commands (d, N, b) that do change flow control.
Unless the default output is suppressed (-n), the print command will cause duplicate copies of a line to be output


## Print line number

```
$ echo -e 'something\n\tif\nother bli bla blubr\n\n\nasdf' | sed "/$(echo -n -e '\t')if/{
=
p
}"
something
2
        if
        if
other bli bla blubr


asdf
```

