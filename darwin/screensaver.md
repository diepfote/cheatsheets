# Mac OS Tahoe

## Set screensaver to loop through pictures in a folder

<https://www.hexnode.com/mobile-device-management/help/script-to-set-screen-saver-on-mac/>

```text
$ defaults -currentHost write com.apple.ScreenSaverPhotoChooser SelectedFolderPath -string ~/Pictures/screensaver/
# use a custom folder as the source = 4
$ defaults -currentHost write com.apple.ScreenSaverPhotoChooser SelectedSource -int 4
```
