# Firejail

## How to extract data from a firejailed process

snatched from <https://github.com/netblue30/firejail/issues/1812#issuecomment-372674179>

```text
$ firewardened-firefox ~/Standard\ Notes\ Backups/decrypt.html

# _firewardened-app start https://github.com/diepfote/scripts/blob/5580f8121e3758f999da15418fd2b733c6194bf2/source-me/linux/posix-compliant-shells.sh#L123
# -> bash ...
$ ps -ef | grep firefox | grep -v grep
# get firejailed process -> /usr/bin/firejail ...
$ ps -ef | grep 68676 | grep -v grep 

$ sudo firejail --join-filesystem=68702 ls -alh ~
$ firejail --put=<pid>   <path-in-jail>  <path-outside-of-jail>
$ firejail --put=68702 Standard\ Notes\ Backups/2023-04-08T05-08-31.544Z.txt ~/asdf.txt
```

## How to put a file into a firejailed process

snatched from <https://github.com/netblue30/firejail/issues/1812#issuecomment-372674179>

```text
$ firejail --get=<pid>   <path>
$ firejail --get=68702 ~/Downloads/decrypted-sn-data.txt
```
