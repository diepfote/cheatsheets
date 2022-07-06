# Container or Linux VM video and audio playback

XQuartz and pulseaudio need to be installed and running.
I assume you already started XQuartz. For XQuartz be sure to 
set `Authenticate connections` in the `Security` Tab, then run
`xhost + local-ip` to allow connections from interface en0.

## Test video

Run on Mac

```
$ local-ip # interface en0
```

Run in Container or VM

```
192.168.0.121

$ ls -alh /tmp/.X11-unix/
total 4.0K
drwxrwxrwt  1 root root  96 Jul  6 00:29 .
drwxrwxrwt 11 root root 280 Jul  6 00:22 ..
srwxrwxrwx  1 lima root   0 Jul  6 00:29 X2
$ export DISPLAY=192.168.0.121:2  # lima vm, second monitor as this dir contains `X2`

$ zathura
```

## Use video and audio

Run on Mac

```
$ pulseaudio --load=module-native-protocol-tcp --exit-idle-time=500 --daemon  # Mac OS
$ pulseaudio --check -v
..Daemon running..
$ local-ip # interface en0
192.168.0.121
```

Run in Container or VM 

**be sure to do the [previous step](#test-video)**

```
$ export PULSE_SERVER=192.168.0.121
# check for audio and video device errors
$ vlc
```
