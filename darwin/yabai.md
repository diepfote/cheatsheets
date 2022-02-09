# Yabai

## Scripting-addition

### Big Surf 

#### Partially disable System Integrity Protection

Do this in Recovery Mode --> Restart and hold `cmd+R`

```
$ csrutil status
System Integrity Protection status: unknown (Custom Configuration).

Configuration:
        Apple Internal: disabled
        Kext Signing: enabled
        Filesystem Protections: disabled
        Debugging Restrictions: disabled
        DTrace Restrictions: enabled
        NVRAM Protections: enabled
        BaseSystem Verification: enabled

This is an unsupported configuration, likely to break in the future and leave your machine in an unknown state.

$ csrutil disable --with nvram --with dtrace --with basesystem --with kext
```

#### Load scripting-addition

Run once

```
sudo yabai --install-sa
```

Put this into `/etc/sudoers`

```
%admin ALL = NOPASSWD: /usr/local/bin/yabai --load-sa
```

Put this at the top of your `~/.yabairc`

```
# the scripting-addition must be loaded manually if
# you are running yabai on macOS Big Sur. Uncomment
# the following line to have the injection performed
# when the config is executed during startup.
#
# for this to work you must configure sudo such that
# it will be able to run the command without password
#
# see this wiki page for information:
#  - https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)
#
sudo yabai --load-sa
yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
```

