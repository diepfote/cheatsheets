# Rsync

## rsync via ssh. custom key file

```
rsync --progress -av  -e 'ssh -i ~/.ssh/podman-remote' florian@192.168.0.171:/Users/florian/Movies/totalbiscuit  /home/flo/Videos/totalbiscuit
```
