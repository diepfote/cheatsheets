## modified version of http://jasonwryan.com/blog/2012/02/13/chroot/

# enable volume group
vgchange -ay

# show all available lvs
lvdisplay | grep -i 'lv name'

mkdir /mnt/arch
mount /dev/mapper/VolGroup00-root /mnt/arch

cd /mnt/arch

## custom
mount /dev/mapper/VolGroup00-boot boot
mount /dev/mapper/VolGroup00-var var
mount /dev/mapper/VolGroup00-opt opt
#mount /dev/mapper/VolGroup00-home home

mount -t proc proc proc/
mount -t sysfs sys sys/
mount -o bind /dev dev/

# chroot . /bin/bash
arch-chroot /mnt/arch

