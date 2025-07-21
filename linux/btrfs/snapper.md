# Snapper

## Common Pitfalls

### 1st

A snapshot I created for `home` ends up in `root`

```text
# Wrong but no error message
snapper create -c home create -d "2024-07-01"
```

Why?

`-c` ... is a global option  
`create -c` ... is a command specific option (`cleanup-algorithm`)


How can you avoid this?  
Use `--config` instead, the create command will complain as this is an
invalid option for `create`. And obviously use the global option, not the commmand
local option.  
`snapper create --config home ...` to `snapper --config home create ...`

### 2nd

n/a
