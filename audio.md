# Audio

## Dynamic range compression

Mostly snatched from https://medium.com/@jud.dagnall/dynamic-range-compression-for-audio-with-ffmpeg-and-compand-621fe2b1a892

```
mkdir -p /tmp/drc && find . ! -name '*dynamic-range-compressed*' -name '*.m4a' -exec bash -c 'new="$(basename "$0" | sed -r "s#(\.m4a$)#_dynamic-range-compressed\\1#")"; ffmpeg -i "$0" -filter_complex "compand=attacks=0:points=-45/-900|-40/-5|-5/-5|0/-5:gain=3" /tmp/drc/"$new"' {} \;
```

