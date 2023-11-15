# Video cropping

## ffmpeg

snatched from <https://stackoverflow.com/a/52675535>

```
$ ffmpeg -i 'file.mov'  -filter:v 'crop=iw:ih-40' 'file-cropped.mp4'
```

`ffmpeg -y -hide_banner -i "test.avi" -filter:v "crop=iw-400:ih-40,scale=960:720" -pix_fmt yuv420p output_video.mp4`

Quick explanation (literal quote from <https://stackoverflow.com/a/52675535>):  
crop=iw-400:ih-40 Cropping 400 from the input width (iw) (2x200 left/right) Cropping 40 from the input height (ih) (2x20 top/bottom) You can cut a little more off if you want a 'crisper' edge.  
scale=960:720 Scaling the video slightly to bring it back to your original 720p, the 960 is to keep it at a nice 4x3 ratio. This scaling is not needed, your preference.  
