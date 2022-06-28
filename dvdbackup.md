# DVD backup | dvdbackup

All information taken from https://wiki.archlinux.org/title/Dvdbackup.

## backup entire dvd (creates folder)

```
$ mkdir /tmp/test-dvd
$ dvdbackup -i /dev/sr0 -o /tmp/test-dvd -M
```


## create iso from backup

```
$ mkisofs -dvd-video -udf -o ~/Videos/movies_and_series/some.iso  /tmp/test-dvd/Some\ Movie\ Name
Setting input-charset to 'UTF-8' from locale.
The pad was 9 for file VIDEO_TS.BUP
  0.15% done, estimate finish Tue Jun 28 21:27:56 2022
  0.30% done, estimate finish Tue Jun 28 21:27:56 2022
  ...
```
