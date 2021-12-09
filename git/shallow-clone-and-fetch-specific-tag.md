# Shallow clone & fetch specific tag

```
$ git clone --depth=1 git@hostname/orga/repo /tmp/test4
Cloning into '/tmp/test4'...
remote: Enumerating objects: 3576, done.
remote: Counting objects: 100% (3576/3576), done.
remote: Compressing objects: 100% (2821/2821), done.
remote: Total 3576 (delta 811), reused 2214 (delta 373), pack-reused 0
Receiving objects: 100% (3576/3576), 3.86 MiB | 544.00 KiB/s, done.
Resolving deltas: 100% (811/811), done.
/tmp
$ cd test4/
/tmp/test4
$ git l
* d91d6a4 (grafted, HEAD -> master, origin/master, origin/HEAD) <another@something> () (Fri Nov 12 10:23:06 2021 +0000) Merge pull request #4285 from asdf/asdfl3
/tmp/test4
$ git tag
/tmp/test4

# fetch specific tag in shallow copy; snatched from
# https://stackoverflow.com/a/19205680

$ git fetch --update-head-ok origin +refs/tags/2018.40:master
remote: Enumerating objects: 11989, done.
remote: Counting objects: 100% (11988/11988), done.
remote: Compressing objects: 100% (5050/5050), done.
remote: Total 11764 (delta 6311), reused 11541 (delta 6220), pack-reused 0
Receiving objects: 100% (11764/11764), 2.20 MiB | 844.00 KiB/s, done.
Resolving deltas: 100% (6311/6311), completed with 66 local objects.
From hostname:orga/repo
 + d91d6a4...a7c53c1 2018.40    -> master  (forced update)
 * [new tag]         2018.40    -> 2018.40
 * [new tag]         2018.29    -> 2018.29
 * [new tag]         2018.30    -> 2018.30
 * [new tag]         2018.31    -> 2018.31
 * [new tag]         2018.32    -> 2018.32
 * [new tag]         2018.33    -> 2018.33
 * [new tag]         2018.34    -> 2018.34
 * [new tag]         2018.35    -> 2018.35
 * [new tag]         2018.36    -> 2018.36
 * [new tag]         2018.37    -> 2018.37
 * [new tag]         2018.38    -> 2018.38
 * [new tag]         2018.39    -> 2018.39
/tmp/test4
$ git tag
2018.29
2018.30
2018.31
2018.32
2018.33
2018.34
2018.35
2018.36
2018.37
2018.38
2018.39
2018.40
/tmp/test4
$ git l
*   a7c53c1 (HEAD -> master, tag: 2018.40) <a-name@a-domain> () (Thu Oct 4 11:31:58 2018 +0200) Merge pull request #256 from bliblablu/asdfh
```
