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

