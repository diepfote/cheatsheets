# Initcpio Initramfs mkinitcpio

## Remove hooks from initramfs

*Remove hooks from Initcpio*

Adjust fallback_options in the `.preset` file for your kernel type.
e.g. `linux-lts.preset`  
`-S` ... removes default hooks for fallback


`/etc/mkinitcpio.d/linux-lts.preset`:

```text
...
fallback_options="-S autodetect,switchsnaprotorw,resume"
```
