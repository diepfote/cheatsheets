# Torrent Client

## Docker image

Based on upstream `go` and `anacrolix/torrent`.

<https://github.com/diepfote/dockerfiles/tree/master/torrent>

### Check if update is required

```text
less ~/Documents/dockerfiles/torrent/Dockerfile
build-container-image torrent
```

### Use the torrent lib

```text
+ /opt/homebrew/bin/docker run --rm -it torrent bash
root@9de117832b6c:/go# torrent download 'magnet:?xt=urn:btih:9cbdc6927dc328ceb82fdd695d709a23db3ec80b&dn=archlinux-2024.03.01-x86_64.iso'
13.375µs: getting torrent info for "archlinux-2024.03.01-x86_64.iso"
```
