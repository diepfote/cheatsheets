# LFS in general

*) retrieve pointer stored in git

```text
$ git lfs untrack '*.zip'
Untracking "*.zip"
$ git checkout -- docker-slides/fonts/Open_Sans.zip
$ bat docker-slides/fonts/Open_Sans.zip
version https://git-lfs.github.com/spec/v1
oid sha256:91693be5c509f738700c781c4604536cd4c4bf30cf448e78e7d21f7378ca427b
size 593525
```

*) check pointer

```text
$ git lfs pointer --check --file=docker-slides/fonts/Open_Sans.zip && echo valid || echo invalid
valid
```

*) get pointer that would be generated (file needs to be checked out obviously, not a pointer file, otherwise the results will differ)

```text
$ git lfs track '*.zip'
$ git lfs checkout
Checking out LFS objects: 100% (71/71), 24 MB | 0 B/s, done.
/tmp/test-something
$ git lfs pointer --file=docker-slides/fonts/Open_Sans.zip
Git LFS pointer for docker-slides/fonts/Open_Sans.zip

version https://git-lfs.github.com/spec/v1
oid sha256:91693be5c509f738700c781c4604536cd4c4bf30cf448e78e7d21f7378ca427b
size 593525
```
