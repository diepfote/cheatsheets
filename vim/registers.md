# Vim Registers

"manpage" -> :help registers

view current register values -> :registers

## change three words and put the previous three words into register c
"cc3w

## Append the current line to register a
"Ayy

## Blackhole register -> do not affect my unnamed register!
"_
e.g. delete current line
"_dd

## record macro then use it again
qq -> do whatever -> q

run macro
  :normal @q 

## previous command register
":

after running a substitution one can repeat it using :@:

