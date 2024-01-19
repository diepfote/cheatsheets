# Rsync

## rsync via ssh. custom key file

```text
rsync --progress -av  -e 'ssh -i ~/.ssh/podman-remote' florian@192.168.0.171:/Users/florian/Movies/totalbiscuit  /home/flo/Videos/totalbiscuit
```

## to container in kubernetes | rsync to kubernetes pod

```text
$ rsync --progress -aOv --blocking-io --rsync-path=/dir/in/container --rsh="kubectl exec -n the-namespace pod-name -i -- " local-file.txt  rsync:
sending incremental file list
local-file.txt
    102,727,104   3%  542.99kB/s    1:19:55
```

