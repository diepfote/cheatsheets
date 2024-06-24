# Linux Power Management

## Current battery charge level

```text
find /sys/devices/ -name 'BAT*' -exec sh -c 'cat "$0"/capacity' {} \;
```
