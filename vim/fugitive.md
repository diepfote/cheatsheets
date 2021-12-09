# Fugitive.vim

```
:Gedit branchname:/path/to/file 
 " autocompletion for branchname and fpath
:Gedit SHA-hash (any git object, blob, tag, tree, 
 " hit enter on parent in tree --> goes to this commit
 " git ls-tree sha-hash --> get version of file at the time of commit/tree object
   " --> git show hash
   " in fugitive on a tree press "a", toggles between git ls-tree and git show
   " in ls-tree view we can go into each sub-tree or inspect blobsx
   " go back to where we started :edit %:h
   " :Gedit no arguments --> working tree version of the current file


   " :0Glog --> quickfix window for all previous commits for the file

   " working copy :Ggrep <pattern>
   " different branch  :Ggrep <pattern> <branch>
```
