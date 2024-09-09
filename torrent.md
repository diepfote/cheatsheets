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
$ mkdir -p /tmp/data && docker run -w /data -v /tmp/download:/data --rm -it torrent bash
root@5f2f1fd4f324:/data# torrent download magnet:?xt=urn:btih:cfc214278888c26cb1516399a304c4f74ff6a810&dn=archlinux-2024.08.01-x86_64.iso
[1] 2
root@5f2f1fd4f324:/data# 145.017µs: getting torrent info for "infohash:cfc214278888c26cb1516399a304c4f74ff6a810"
```
