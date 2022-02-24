# Logitech Mutli-Device K780

## switch slots

press one of F1,F2,F3

## connect to a new device
press one of the keys metioned in [switch slots](#switch-slots) for 3 seconds

## change keyboard layout to Mac

press fn + O for 3 seconds

## change keyboard layout to Windows

press fn  + P for 3 seconds

## swap function keys | swap fn keys

### Arch Linux

```
sudo pacman -S solaar

sudo solaar show
```

**Hint**: Device numbers in `solaar show` do not necesarrily reflect device numbers used for `solaar config`

```
# device number in `solaar show was '2'`, number I had to use was '`3`'
sudo solaar config 3 fn-swap False
```

