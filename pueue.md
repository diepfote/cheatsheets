# Pueue

<https://github.com/Nukesor/pueue>

## Filtering

### Failure

Default

```text
pueue status -g now -- columns=id,status,command status=failed
```

JSON

```text
pueue status -g now -j | jq '.tasks[] | select(.status.Done? and (.status.Done.result | type) == "object" and (.status.Done.result | has("Failed")))  | .id'
```

### Success

Default

```text
pueue status -g now -- columns=id,status,command status=failed
```

JSON

```text
pueue status -g now -j | jq '.tasks[] | select(.status.Done? and (.status.Done.result | type) == "string" and (.status.Done.result == "Success"))  | .id'
```

### Queued

Default

```text
pueue status -g now -- columns=id,status,command status=queued
```

JSON

```text
pueue status -j | jq '.tasks[] | select(.status | has("Queued")) | .id'
```

### Running

Default

```text
pueue status -g now -- columns=id,status,command status=running
```

JSON

```text
pueue status -j | jq '.tasks[] | select(.status | has("Running")) | .id'
```

## PQ Helpers

### Filtering

Find tasks that resulted in an increase in file size

```text
$ pq log -g now --lines 1000  |& grep -E 'Task [0-9]+|≈' | grep -B 1 -F '0.'
```

Show filename for tasks that resulted in an increase in file size

```text
$ pq log -g now --lines 1000  |& grep -E 'Task [0-9]+|≈' | grep -B 1 -F '0.' | grep Task | awk -F : '{ print $1 }' | awk '{ print $3 }' | xargs -n 1 pq log --lines 1
```
