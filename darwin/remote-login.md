# Remote login

Taken from <https://osxdaily.com/2016/08/16/enable-ssh-mac-command-line/>

---

Can be enabled and disabled via the cli:

```text
systemsetup -f -setremotelogin on
systemsetup -f -setremotelogin off
```

Get current status via:

```text
systemsetup -getremotelogin
```
