# General

```text
sort unique    :sort u

back to previous location   <CTRL+O>
back to last edit           `.

reset file                  :e!
insert at start of line      I
append at end of line        A
insert new line above        O
insert new line below        o

move forward to start of a word  w
move forward to end of a word  e
move backward to start of a word  b


change word                          cw
change 2 words                       c2w
change to the end of the line        c$
change to the beginning of the line  c0
change rest of line                  C

clear entire line and enter insert mode  S
clear entire line                        D
overstrike mode                          R

get back n-th deletion  "np, e.g. "1p

yank four lines      4yy/"+4yy
yank to end of line  y

join current and line below  J

character text object  l
copy 4 characters to clipboard  4yl

delete 3 lines downwards     d3d
delete 3 lines upwards       d3-d

move two words forward       2w
move two words backward      2b

replace in selection      :'<,'>s/regex/replacement/options

replace start-of-line with '"' for every line that contains FocusLost
  :g/FocusLost/s/^/"

replay a regex match    :%s/child\([□,.;:!?]\)/children\1/g

delete blank lines      :g/^$/d

search forward/backward in line   fx OR Fx
search ...... (stop before char)  tx  OR Tx
repeat search forward    ;
repeat search backward   ,

substitute foo for bar between absolute lines  :127,215 s/foo/bar
substitute foo for bar between relative lines  :+2,+4 s/foo/bar

delete empty lines from current through the next 2 lines  :.,+2g /^$/d
delete empty lines from current to end of file            :.,$g/^$/d
delete non-empty lines from current to end of file        :.,$v/^$/d

move matching lines to end of file (*scratch space*)     :% g/pattern/m$

Opens file at the first occurence of pattern   $ vi +/pattern file
Opens file at last line                        $ vi + file

Read in the contents of a file
  :r <filename>

Read the contents of a file at the top of the file (do not insert a new line)
  :0r <filename>
  :0r ! command


There are 26 named buffers, not just vim's default and clipboard
  yank to buffer named "a"     "ay
  paste from buffer named "a"  "ap


copy the contents of the b register to a:
  :let @a=@b

indent a block
  >aB
unindent a block
  <aB


check who rebound your key
  https://stackoverflow.com/questions/11562654/vim-ctrl-keys-not-working
  :verbose nmap <leader>s
  :verbose <mode> <keys>


yank inner big word
  yiW
  e.g. an ip address, yiw on 160.64.56.23 would yank 160
       yiW will yank 160.64.56.23

unload multiple buffers listed by :ls
  :<start>,<end>bd

unload current buffer
  :bd

unload specific buffer
  :<buf_num>bd

close all buffers except current
  :%bd | e#

display all options
  :set all

display specific option
  :set <option>?

jump to the end of a search result
/pattern/e

restore visual selection (run in normal mode)
  gv

redirect to stdout  # https://superuser.com/a/1692033
  nvim -e +"redir>>/dev/stdout | echo &undodir | redir END" -scq
```
