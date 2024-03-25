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

## How to start qemu with more than 4 mounted disks

snatched from <https://unix.stackexchange.com/a/597144>

instead of `-hde`, `-hdf` etc we have to use `-drive file=...qcow2,if=virtio,index=<num>,format=qcow2`

Long example:

```text
qemu-system-x86_64 -hda mfsbsd-root-disk.qcow2 -hdb mfsbsd-raidz2-disk1.qcow2 -hdc mfsbsd-raidz2-disk2.qcow2 -hdd mfsbsd-raidz2-disk3.qcow2 -drive file=mfsbsd-raidz2-disk4.qcow2,if=virtio,index=4,format=qcow2 -drive file=mfsbsd-raidz2-disk5.qcow2,if=virtio,index=5,format=qcow2 -drive file=mfsbsd-raidz2-disk6.qcow2,if=virtio,index=6,format=qcow2
```

## How to create a qcow2 disk image in qemu

snatched from <https://serverfault.com/a/731451>

```text
qemu-img create -f qcow2 mfsbsd-raidz2-disk6.qcow2 5G
```


## How to boot an iso file in qemu

`... --boot d --cdrom <iso-file> ...`

`d` ... boot from disk

Full example:

```text
qemu-system-x86_64 --boot d --cdrom mfsbsd-14.0-RELEASE-amd64.iso -smp 2 -m 4096 -hda mfsbsd-root-disk.qcow2
```

## How to specify available memory for guest in qemu

`-m <value>`


## How to specify multiple virtual cpus in qemu

`-smp <value>`


