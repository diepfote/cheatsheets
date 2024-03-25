# ZFS

## How to create a ZFS raidz2

`sudo zpool create -f test-pool raidz2 ada1 ada2 ada3 vtbd0`

## How to simulate a ZFS failure

<https://wiki.archlinux.org/title/ZFS/Virtual_disks#Simulate_a_disk_failure_and_rebuild_the_Zpool>

Sidenote: Did this in the test below: DD drives in the raidz, scrub, show status, replace, show status.

## Raidz2 test 2024-03-24

```text
raidz2 on freebsd. use 4 disks

simulate failure: use the arch documentation as a reference
qemu-img create -f qcow2 mfsbsd-raidz2-disk1.qcow2 5G ...

qemu-system-x86_64 -smp 2 -m 4096 -hda mfsbsd-root-disk.qcow2  -nic user,hostfwd=tcp::10022-:22 -hdb mfsbsd-raidz2-disk1.qcow2 -hdc mfsbsd-raidz2-disk2.qcow2 -hdd mfsbsd-raidz2-disk3.qcow2 -drive file=mfsbsd-raidz2-disk4.qcow2,if=virtio,index=4,format=qcow2 -drive file=mfsbsd-raidz2-disk5.qcow2,if=virtio,index=5,format=qcow2 -drive file=mfsbsd-raidz2-disk6.qcow2,if=virtio,index=6,format=qcow2

sudo zpool create -f test-pool raidz2 ada1 ada2 ada3 vtbd0

sudo zpool status test-pool

dd if=/dev/zero of=mfsbsd-raidz2-disk1.qcow2 bs=4M count=1
dd if=/dev/zero of=mfsbsd-raidz2-disk2.qcow2 bs=4M count=1

sudo zpool scrub test-pool

sudo zpool status test-pool

---

https://mfsbsd.vx.sk/

freebsd change keyboard layout:
kbdcontrol -l de
start install:
bsdinstall

basic admin setup
pkg install bash sudo
visudo
jack ALL=(ALL) ALL
```
