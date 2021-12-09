# Jq filtering

## show resources requests for specific container in a statefulset

```
oc get pod -n asdf-blub-namespace -o json | jq '.items[].spec.containers[] | select(.name == "container-name") | .resources.requests'
```

