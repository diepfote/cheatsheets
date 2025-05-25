# GRUB Reinstall

## EFI

TBD

## BIOS

Based on <https://wiki.archlinux.org/index.php/GRUB#Installation> and
         <https://unix.stackexchange.com/a/346206>

```text
target_device=/dev/sda
grub-install --target=i386-pc  --boot-directory=/mnt/arch/boot --root-directory=/mnt/arch  "$target_device"
```
