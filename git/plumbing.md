# Git Plumbing

Snatched from [Dissecting Git's Guts, Emily Xie - Git Merge 2016](https://www.youtube.com/watch?v=Y2Msq90ZknI)  

## Basic object types

### How git stores files

Store a file in git manually

```
$ cd /tmp/test
$ git init
$ echo 'Hello World!' > hello_world.txt
/tmp/test
$ git hash-object -w hello_world.txt
980a0d5f19a64b4b30a87d4206aade58726b60e3
```

Content addressable filesystem. Read content addressable by hash.
```
$ ls -alh .git/objects/98/0a0d5f19a64b4b30a87d4206aade58726b60e3
-r--r--r-- 1 florian.begusch wheel 29 Dec 14 08:02 .git/objects/98/0a0d5f19a64b4b30a87d4206aade58726b60e3
$ git cat-file -p 980a0d5f19a64b4b30a87d4206aade58726b60e3
Hello World!
```

How to generate the hash yourself

```
$ printf 'blob 13\000Hello World\041\n' | openssl sha1
980a0d5f19a64b4b30a87d4206aade58726b60e3
```

### How git stores folder structure

#### Mimic `git add`

Add to stash/index

```
$ git update-index --add hello_world.txt
$ git update-index --add foo_bar.txt
```

Inspect index

```
# binary content
less .git/index

$ git ls-files --stage
100644 9af24d2496973bb2603bb4ebd6ea3bba6179b577 0       foo_bar.txt
100644 980a0d5f19a64b4b30a87d4206aade58726b60e3 0       hello_world.txt
```

#### Write tree to git

```
$ git write-tree
e4ff61e51b77e4e42e3b687ab8a086b24db2e16d
```

Trees are hash addressable as well

```
$ git cat-file -p e4ff61e51b77e4e42e3b687ab8a086b24db2e16d
100644 blob 9af24d2496973bb2603bb4ebd6ea3bba6179b577    foo_bar.txt
100644 blob 980a0d5f19a64b4b30a87d4206aade58726b60e3    hello_world.txt
```

```
$ find .git/objects -type f
.git/objects/e4/ff61e51b77e4e42e3b687ab8a086b24db2e16d  # tree
.git/objects/9a/f24d2496973bb2603bb4ebd6ea3bba6179b577  # blob
.git/objects/98/0a0d5f19a64b4b30a87d4206aade58726b60e3  # blob
```


### Mimic `git commit`/Write commit object

A commit knows when trees were written and contains information about committer and author.

```
$ echo 'first commit' | git commit-tree e4ff61e51b77e4e42e3b687ab8a086b24db2e16d
040ee26513c799dfda3316f06df78bade3dddf99
```

```
$ git cat-file -p 040ee26513c799dfda3316f06df78bade3dddf99
tree e4ff61e51b77e4e42e3b687ab8a086b24db2e16d
author Florian Begusch <florian.begusch@gmail.com> 1673844479 +0000
committer Florian Begusch <florian.begusch@gmail.com> 1673844479 +0000

first commit
```

```
$ find .git/objects -type f
.git/objects/04/0ee26513c799dfda3316f06df78bade3dddf99
.git/objects/e4/ff61e51b77e4e42e3b687ab8a086b24db2e16d
.git/objects/9a/f24d2496973bb2603bb4ebd6ea3bba6179b577
.git/objects/98/0a0d5f19a64b4b30a87d4206aade58726b60e3
```


#### How git commits create parent commit relations

```
$ echo asdf > foo_bar.txt
git update-index --add foo_bar.txt
git write-tree
eb606ccdc530241cc740e97ea8d87c15a6cc3e69
$ echo 'second commit' | git commit-tree  eb606ccdc530241cc740e97ea8d87c15a6cc3e69
7edad5bf0e1967282ce4452464bca10ffc56bd66
```

```
$ git cat-file -p 7edad5bf0e1967282ce4452464bca10ffc56bd66
tree eb606ccdc530241cc740e97ea8d87c15a6cc3e69
author Florian Begusch <florian.begusch@gmail.com> 1673844947 +0000
committer Florian Begusch <florian.begusch@gmail.com> 1673844947 +0000

second commit
```

## Git references

### Create a branch

Git branches are aliases or pointers to commit objects

```
$ find .git/refs/heads -type f
empty, no branches yet
```

Add a master branch, point it at a commit

```
$ git update-ref refs/heads/master 7edad5bf0e1967282ce4452464bca10ffc56bd66
```

```
$ find .git/refs/heads -type f 
.git/refs/heads/master
$ cat .git/refs/heads/master
7edad5bf0e1967282ce4452464bca10ffc56bd66
```

#### Branch off of a given branch

It just duplicates the pointer

```
$ git checkout -b feature
```

```
$ find .git/refs/heads -type f 
.git/refs/heads/master
.git/refs/heads/feature
$ cat .git/refs/heads/feature
7edad5bf0e1967282ce4452464bca10ffc56bd66
```

### What is the current branch? HEAD/detached HEAD or headless

```
$ cat .git/HEAD 
ref: refs/heads/feature
```

## Pack objects

### Example

Loose objects

```
$ find .git/objects -type f  
.git/objects/04/0ee26513c799dfda3316f06df78bade3dddf99
.git/objects/eb/606ccdc530241cc740e97ea8d87c15a6cc3e69
.git/objects/e4/ff61e51b77e4e42e3b687ab8a086b24db2e16d
.git/objects/7e/dad5bf0e1967282ce4452464bca10ffc56bd66
.git/objects/9a/f24d2496973bb2603bb4ebd6ea3bba6179b577
.git/objects/98/0a0d5f19a64b4b30a87d4206aade58726b60e3
.git/objects/8b/d6648ed130ac9ece0f89cd9a8fbbfd2608427a
$ git count-objects -H
7 objects, 28.00 KiB
```

Garbage collect

```
$ git gc
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 12 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (4/4), done.
Total 4 (delta 0), reused 0 (delta 0), pack-reused 0
```

Packed repo

```
$ git count-objects -H
3 objects, 12.00 KiB
$ find .git/objects -type f  
.git/objects/04/0ee26513c799dfda3316f06df78bade3dddf99
.git/objects/e4/ff61e51b77e4e42e3b687ab8a086b24db2e16d
.git/objects/pack/pack-2bf9b004e25e7885f2a76d2a592375642b224422.idx  # index into packfile (offsets)
.git/objects/pack/pack-2bf9b004e25e7885f2a76d2a592375642b224422.pack  # pack file
.git/objects/9a/f24d2496973bb2603bb4ebd6ea3bba6179b577
.git/objects/info/commit-graph
.git/objects/info/packs  # which packs exit?
```

Show contents of pack

```
$ git verify-pack -v .git/objects/pack/pack-2bf9b004e25e7885f2a76d2a592375642b224422.pack
7edad5bf0e1967282ce4452464bca10ffc56bd66 commit 200 126 12
8bd6648ed130ac9ece0f89cd9a8fbbfd2608427a blob   5 14 138
980a0d5f19a64b4b30a87d4206aade58726b60e3 blob   13 22 152
eb606ccdc530241cc740e97ea8d87c15a6cc3e69 tree   82 87 174
non delta: 4 objects
.git/objects/pack/pack-2bf9b004e25e7885f2a76d2a592375642b224422.pack: ok
```

