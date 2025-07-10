# Types of clones

* blobless ... `git clone --filter=blob:none <url>`
* treeless ... `git clone --filter=tree:0 <url>`
* full
* shallow  ... `git clone --depth=1 --branch=master <url>`

“We strongly recommend that developers do not use treeless clones for
their daily work. Treeless clones are really only helpful for automated
builds when you want to quickly clone, compile a project, then throw away
the repository.”

“Partial clones are relatively new to Git, but there is an older feature
that does something very similar to a treeless clone: shallow clones.
Shallow clones use the `--depth=<N>` parameter in git clone to truncate
the commit history.”

“Shallow clones are best combined with the
`--single-branch --branch=<branch>` options as well, to ensure we only
download the data for the commit we plan to use immediately.”

Difference treeless - shallow:

* a treeless clone contains every commit,
* a shallow clone only the last (or depth=N) commits.
  Trees and blobs up to that depth are downloaded.

“For these reasons we do not recommend shallow clones except for builds
that delete the repository immediately afterwards. Fetching from shallow
clones can cause more harm than good!”

Excerpts From
[Get up to speed with partial clone and shallow clone - Derrick Stolee](https://github.blog/open-source/git/get-up-to-speed-with-partial-clone-and-shallow-clone/)

