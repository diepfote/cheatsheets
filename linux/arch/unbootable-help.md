# Unbootable: Help

Fix initramfs, grub config or grub install.

Or just chroot your system to fix a package.

## New config

`EFI + LUKS + BTRFS`

### Arch Chroot

```text
loadkeys de

mkdir /mnt-key
cryptsetup open --key-file /mnt-key/crypto_keyfile.bin /dev/nvme0n1p2 crypt-root

mkdir /mnt-root

# fetch most up-to-date mount point info
mount -o ro /dev/mapper/crypt-root /mnt-root
cat /etc/fstab
umount /mnt-root

# get subvol ids
btrfs subvol list / | less

# root
mount -o noatime,compress=zstd:3,ssd,discard,space_cache=v2,subvolid=412,subvol=/@  /dev/mapper/crypt-root /mnt-root

# var log
mount -o noatime,compress=zstd:3,ssd,discard,space_cache=v2,subvolid=258,subvol=/@varlog  /dev/mapper/crypt-root /mnt-root/var/log

# pacman pkgs
mount -o noatime,compress=zstd:3,ssd,discard,space_cache=v2,subvolid=260,subvol=/@packages  /dev/mapper/crypt-root /mnt-root/var/pacman/pkg


# boot
mount /dev/nvme0n1p1 /mnt-root/boot

mount -t proc proc /mnt-root/proc
mount -t sysfs sys /mnt-root/sys
mount -o bind /dev /mnt-root/dev

arch-chroot /mnt-root
```

### Re-create Initramfs


```text
mkinitcpio -P
```

### Reinstall Grub

TBD

### Re-create Grub Config

```text
grub-mkconfig -o /boot/grub/grub.cfg
```

## Old config

`BIOS + LUKS + LVM + EXT4`

Modified version of <http://jasonwryan.com/blog/2012/02/13/chroot/>:

```text
# enable volume group
vgchange -ay

# show all available lvs
lvdisplay | grep -i 'lv name'

mkdir /mnt/arch
mount /dev/mapper/VolGroup00-root /mnt/arch

cd /mnt/arch

# custom mounts
mount /dev/mapper/VolGroup00-boot boot
mount /dev/mapper/VolGroup00-var var
mount /dev/mapper/VolGroup00-opt opt
#mount /dev/mapper/VolGroup00-home home

mount -t proc proc proc/
mount -t sysfs sys sys/
mount -o bind /dev dev/

# chroot . /bin/bash
arch-chroot /mnt/arch
```
