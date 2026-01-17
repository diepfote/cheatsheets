# EFI

## how to reinstall grub on my machines

```
# verify this location
[root@frame ~]# ls -alh /boot/{EFI,grub}
/boot/EFI:
total 16K
drwxr-xr-x 4 root root 4,0K Sep 23 19:13 .
drwxr-xr-x 4 root root 4,0K Jan  1  1970 ..
drwxr-xr-x 2 root root 4,0K Aug 20  2024 GRUB
drwxr-xr-x 2 root root 4,0K Sep 23 19:13 UpdateCapsule

/boot/grub:
total 224K
drwxr-xr-x 7 root root 4,0K Jan 17 14:16 .
drwxr-xr-x 4 root root 4,0K Jan  1  1970 ..
drwxr-xr-x 2 root root 4,0K Jun 26  2024 fonts
-rwxr-xr-x 1 root root 134K Jan 17 14:16 grub-btrfs.cfg
-rwxr-xr-x 1 root root 5,5K Jan 17 14:16 grub.cfg
-rwxr-xr-x 1 root root 1,0K Jun 26  2024 grubenv
-rwxr-xr-x 1 root root 1,3K Aug 18  2024 grub-pre.cfg
drwxr-xr-x 2 root root 4,0K Jul  2  2024 keyboards
drwxr-xr-x 2 root root 8,0K Jan 17 14:16 locale
drwxr-xr-x 3 root root 4,0K Jun 26  2024 themes
drwxr-xr-x 2 root root  44K Jan 17 14:16 x86_64-efi
# then run install
[root@frame ~]# grub-install --target=x86_64-efi --efi-directory=/boot --boot-directory=/boot --bootloader-id=GRUB  # final

# verify this location
[root@frame ~]# ls -alh /boot/grub/grub.cfg
# then regenerate your config
[root@frame ~]# grub-mkconfig  -o /boot/grub/grub.cfg 
```

Note: if there is a grub update we should reinstall grub so the auto-generated 
config (e.g. snapper) will not break. (and obviously any manual config re-gen)

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
