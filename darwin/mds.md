# MDS - Metadata stores used by spotlight

## Disable spotlight search indexing - disable mds

snatched command from <https://apple.stackexchange.com/questions/388882/how-to-disable-spotlight-and-mds-stores-on-mac-os-catalina> and `man mdutil`

mds re-indexes regularly and performance takes a hit.
instead of using spotlight to start applications I use launchpad now.

sidenote: if you disable it, spotlight will not know about any native
          3rd party app you have install.

```text
sudo mdutil -a  -i off
```

