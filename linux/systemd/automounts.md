# Systemd automounts

<https://www.man7.org/linux/man-pages/man5/systemd.automount.5.html>

## remount umounted disk

snatched from <https://bbs.archlinux.org/viewtopic.php?pid=1515377#p1515377>

```
sudo systemctl daemon-reload
sudo systemctl restart local-fs.target
```

## reload crypttab (`/etc/crypttab`)

snatched from <https://bbs.archlinux.org/viewtopic.php?id=167639>

```
sudo systemctl daemon-reload
sudo systemctl restart cryptsetup.target
```
