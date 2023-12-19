# Yabai

## Scripting-addition

### Ventura

#### Partially disable System Integrity Protection

More information at <https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection> & <https://github.com/koekeishiya/yabai/issues/1158>

1. Run `sudo nvram boot-args=-arm64e_preview_abi`

2. Long-press power button until "Loading  boot options" appears.  
    Select "Options" to enter `Recovery Mode`

    ```text
    csrutil enable --without fs --without debug --without nvram
    ```

    Then restart

#### Load scripting-addition

Put this into `/etc/sudoers`

```text
%admin ALL = NOPASSWD: /opt/homebrew/bin/yabai --load-sa
```

Put this at the top of your `~/.yabairc`.

```text
sudo yabai --load-sa
yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
```
