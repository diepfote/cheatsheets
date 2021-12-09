# less

```
       ESC-u  Undo  search  highlighting.  Turn off highlighting of strings matching the current search pattern.  If highlighting is already off
              because of a previous ESC-u command, turn highlighting back on.  Any search command will also turn highlighting back  on.   (High-
              lighting can also be disabled by toggling the -G option; in that case search commands do not turn highlighting back on.)

       &pattern
              Display  only  lines which match the pattern; lines which do not match the pattern are not displayed.  If pattern is empty (if you
              type & immediately followed by ENTER), any filtering is turned off, and all lines are displayed.  While filtering is in effect, an
              ampersand is displayed at the beginning of the prompt, as a reminder that some lines in the file may be hidden.

              Certain characters are special as in the / command:

              ^N or !
                     Display only lines which do NOT match the pattern.

              ^R     Don't interpret regular expression metacharacters; that is, do a simple textual comparison.

       :e [filename]
              Examine  a  new file.  If the filename is missing, the "current" file (see the :n and :p commands below) from the list of files in
              the command line is re-examined.  A percent sign (%) in the filename is replaced by the name of the current file.   A  pound  sign
              (#)  is  replaced  by the name of the previously examined file.  However, two consecutive percent signs are simply replaced with a
              single percent sign.  This allows you to enter a filename that contains a percent sign in the name.   Similarly,  two  consecutive
              pound signs are replaced with a single pound sign.  The filename is inserted into the command line list of files so that it can be
              seen by subsequent :n and :p commands.  If the filename consists of several files, they are all inserted into the  list  of  files
              and  the  first  one  is  examined.  If the filename contains one or more spaces, the entire filename should be enclosed in double
              quotes (also see the -" option).

       ^X^V or E
              Same as :e.  Warning: some systems use ^V as a special literalization character.  On such systems, you may not be able to use  ^V.

       :n     Examine the next file (from the list of files given in the command line).  If a number N is specified, the N-th next file is exam-
              ined.

       :p     Examine the previous file in the command line list.  If a number N is specified, the N-th previous file is examined.

       :x     Examine the first file in the command line list.  If a number N is specified, the N-th file in the list is examined.

       :d     Remove the current file from the list of files.

       t      Go to the next tag, if there were more than one matches for the current tag.  See the -t option for more details about tags.

       T      Go to the previous tag, if there were more than one matches for the current tag.
```

