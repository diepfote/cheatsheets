# Audio

## Dynamic range compression

Mostly snatched from <https://medium.com/@jud.dagnall/dynamic-range-compression-for-audio-with-ffmpeg-and-compand-621fe2b1a892>

[Local copy of the article](./Dynamic%20Range%20Compression%20for%20audio%20with%20ffmpeg%20and%20compand%20_%20by%20Jud%20Dagnall%20_%20Medium%20(2022-12-16%209_12_45%20AM).html)

```bash
mkdir -p /tmp/drc && find . ! -name '*dynamic-range-compressed*' -name '*.m4a' -exec bash -c 'new="$(basename "$0" | sed -r "s#(\.m4a$)#_dynamic-range-compressed\\1#")"; ffmpeg -i "$0" -filter_complex "compand=attacks=0:points=-45/-900|-40/-5|-5/-5|0/-5:gain=3" /tmp/drc/"$new"' {} \;
```

