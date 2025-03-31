# EFI

## unbootable after windows 11 installation

Fix boot failure after installing windows 11 (or trying to install it
)
it will flush your efi boot entry for the other disk you were using
or the same but another parition, whichever.

1. verify its missing

1.1. boot from usb

1.2. check output of `efibootmgr`

2. locate your efi partition with `fdisk -l`

2.1. find the device and partition

2.2. mount it to check the path of the efi executable grubx64.efi.  
it should reside in `/EFI/GRUB/grubx64.efi`, this is `\EFI\GRUB\grubx64.efi` to EFI

3. re-add the entry

```text
# -d ... /dev/sdX or nvme drive
# -p ... paritition number if not default 1
efibootmgr -c -d /dev/nvme0pX -L "GRUB" -l "\EFI\GRUB\grubx64.efi`
```

4. boot order can be a problem, if have not found it to be  
(I only have a single ssd and I disconnected all other devices before retrying)  
if you have to change it use : `efibootmgr -o XXXX`
