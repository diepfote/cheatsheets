# Migrate Repo to LFS

1) Backup your repo

2) set git lfs remote (optional if not default)

```
echo '[lfs] url = "<url-to-lfs-repo>"' > .lfsconfig

git add .lfsconfig
git commit -m 'Add lfs remote config'
```


3) git lfs track <files>

e.g.
```
git lfs track *.png *.html *.svg* *.jpg *.pptx *.pdf *.xcf *.zip
git add .gitattributes
git commit -m 'Add lfs track info'
```

4) git migrate import --include=<files> --everything

Use `--everything` to include files in any local branch

e.g.:

```
git lfs migrate import --include='*.png,*.html,*.svg*,*.jpg,*.pptx,*.pdf,*.xcf,*.zip' --everything
```

5) check if files have been migrated

```
$ git lfs ls-files --all
91693be5c5 - docker-slides/fonts/Open_Sans.zip
850924daa9 - slides/_raw_images/Apache_PoweredBy-2.svg
31bf3067e4 - slides/_raw_images/Apache_PoweredBy.svg
```

6) check if any additional files need to be migrated

(nicked from https://stackoverflow.com/questions/42963854/list-files-not-tracked-by-git-lfs/46215732#46215732)

Show files tracked by git and not in git lfs:

```
{ git ls-files && git lfs ls-files | cut -d' ' -f3-; } | sort | uniq -u
.gitattributes
.github/baumpfleger.yml
.gitignore
.lfsconfig
Makefile
README.md
```


8) set up lfs authentication

e.g. 

```
git config --global credential.helper store  # store on disk (plain-text)
echo 'https://<user>:<password>@<hostname>' > ~/.git-credentials
```


8) Fix `remote: error: GH008: Your push referenced at least XX unknown Git LFS objects:`
***(optional if the step below fails)***


------------
!!!!!!!!!!!!

actually we need to delete the repo on github and re-create it, otherwise GHE will always reject your lfs references in the pre-receive hook. --> step 8

!!!!!!!!!!!!
--------------

Force push error you might encounter in the next step
```
$ git push --force --all
Enumerating objects: 915, done.
Counting objects: 100% (915/915), done.
Delta compression using up to 12 threads
Compressing objects: 100% (409/409), done.
Writing objects: 100% (915/915), 1.83 MiB | 678.00 KiB/s, done.
Total 915 (delta 474), reused 912 (delta 474), pack-reused 0
remote: Resolving deltas: 100% (474/474), done.
remote: error: GH008: Your push referenced at least 42 unknown Git LFS objects:
remote:     91693be5c509f738700c781c4604536cd4c4bf30cf448e78e7d21f7378ca427b
remote:     7c0211cd8f0ae860e1bae9d5fead842c908613bf7b2b51d8bd4188fbbe40fd43
remote:     73b72c7efa07cd8637c8b6b1f44f84d3fd19e3b0a32a4f59916ccbf5e221f98f
remote:     ...
remote: Try to push them with 'git lfs push --all'.
To HOSTNAME:ORG/training
 ! [remote rejected] master -> master (pre-receive hook declined)
error: failed to push some refs to 'HOSTNAME:ORG/training'
```

Now we need to remove all LFS objects, for some reason they are not referenced.  
There are two ways for doing it. As far as I know both of them yield the same results. But the second one is very detious and painful.

First option, delete any files matched by the previous migrate call:
  **Note: This approach will not keep a history of lfs files, only `latest` will remain in the repo**

  1) delete files that are now lfs files based on extension
  ```
  bfg --no-blob-protection -D '*.{png,html,svg*,jpg,pptx,pdf,xcf,zip}'
  ```

Second option  
Repeat the following steps for every offending id (retry pushes if the list of ids is non-exaustive)
  1) retrieve filepath
  ```
  $ git l -p -S 91693be5c509f738700c781c4604536cd4c4bf30cf448e78e7d21f7378ca427b
  ...
  | * | | | 740895e <blub@blub.com> (Fri Aug 2 10:00:24 2019 +0200) Build slides
  |/ / / /  | | | |
  | | | |   diff --git a/docker-slides/fonts/Open_Sans.zip b/docker-slides/fonts/Open_Sans.zip
  | | | |   new file mode 100644
  | | | |   index 0000000..e4751bf
  | | | |   --- /dev/null
  | | | |   +++ b/docker-slides/fonts/Open_Sans.zip
  | | | |   @@ -0,0 +1,3 @@
  | | | |   +version https://git-lfs.github.com/spec/v1
  | | | |   +oid sha256:91693be5c509f738700c781c4604536cd4c4bf30cf448e78e7d21f7378ca427b
  | | | |   +size 593525

  ```
  
  2) delete offending files from git

  ```
  # note this command those not take filepaths sadly
  $ bfg --delete-files 'Open_Sans.zip' --no-blob-protection
  
  Using repo : /private/tmp/backup-test-repo/.git
  ...
  ...
  ...
  In total, 5 object ids were changed. Full details are logged here:

        /private/tmp/backup-test-repo.bfg-report/2021-06-18/08-14-27

BFG run is complete! When ready, run: git reflog expire --expire=now --all && git gc --prune=now --aggressive
  ```

  3) as I said, repeat for all offending ids


Check all relevant files have already been staged &
commit them

```
$ git status -sb
## master...origin/master
A  docker-slides/fonts/Open_Sans.zip
...

$ git commit -m 'Add all lfs tracked files'
```

8) disable branch protection on repo

9) force push all branches

```
git push --force --all

```

10) enable branch protection on repo


7) checkout all lfs files to the working copy (otherwise you will only have pointer files in your working copy)

```
git lfs checkout
```

11) celebrate

----------

# LFS in general

*) retrieve pointer stored in git

```
$ git lfs untrack '*.zip'
Untracking "*.zip"
$ git checkout -- docker-slides/fonts/Open_Sans.zip
$ bat docker-slides/fonts/Open_Sans.zip
version https://git-lfs.github.com/spec/v1
oid sha256:91693be5c509f738700c781c4604536cd4c4bf30cf448e78e7d21f7378ca427b
size 593525
```

*) check pointer

```
$ git lfs pointer --check --file=docker-slides/fonts/Open_Sans.zip && echo valid || echo invalid
valid
```

*) get pointer that would be generated (file needs to be checked out obviously, not a pointer file, otherwise the results will differ)

```
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

