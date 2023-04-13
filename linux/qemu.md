# Qemu

## Mount virtual disk image

snatched from <https://stackoverflow.com/questions/70351250/is-it-possible-to-copy-files-to-qemu-image-without-running-qemu/70360539#70360539>

```text
sudo pacman -S nbd qemu-headless  # minimum qemu or more...
sudo modprobe nbd max_part=8
# check if devices show up now
ls -alh /dev/ | grep nbd

# open image
sudo qemu-nbd -c /dev/nbd1 <some-image-like-qcow2>

# check disk partitions -> what to mount?
sudo fdisk -l /dev/nbd0

temp="$(mktemp -d)"
sudo mount /dev/nbd0 "$temp"

# e.g. if this is a root partition
sudo ls -alh "$temp"/root


# to umount/disconnet
sudo umount "$temp"
sudo qemu-nbd -d /dev/nbd0
```

