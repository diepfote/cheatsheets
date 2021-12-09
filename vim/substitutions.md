# Vim Substitutions

## placeholder for find pattern
"Vim needs a more POSIX compatible shell than fish for certain functionality to
"work, such as `:%!`, compressed help pages and many third-party addons.  If you
"use fish as your login shell or launch Vim from fish, you need to set `shell`
"to something else in your `~/.vimrc`, for example:

:1,4s/.*/(&)/
("Vim needs a more POSIX compatible shell than fish for certain functionality to)
("work, such as `:%!`, compressed help pages and many third-party addons.  If you)
("use fish as your login shell or launch Vim from fish, you need to set `shell`)
("to something else in your `~/.vimrc`, for example:)

## Change case
That or this
:s/\([^ ]\+\)\( [^ ]\+ \)\([^ ]\+\)/\u\3\2\l\1/

This or that

* \l and \u change the first letter
* \U or \L change everything until EOL or \E


subsitute four characters
4s
