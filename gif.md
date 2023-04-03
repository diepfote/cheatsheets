# Gif

## How to generate a gif from video

*snatched from <https://superuser.com/a/556031>*

```sh
ffmpeg -i filename..mov \
       -to 00:00:28 \
       -vf "fps=10" \
       -loop 0 \
       -pix_fmt rgb24 
       output.gif
```

