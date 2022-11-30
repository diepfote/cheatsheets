# Jq filtering

## show multiple fields simultaneoulsy | show 2 fields simultaneoulsy

```
$ oc get pod -n something podname -o json | jq '.status.containerStatuses[] | "\(.state) \(.name)"'
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:50Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:50Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:50Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:50Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:50Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:50Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:52Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:49Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:51Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:51Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:51Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:52Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:51Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:51Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:53Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:51Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:51Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:52Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:53Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:51Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:52Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:52Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:52Z\"}} random-container-name"
"{\"running\":{\"startedAt\":\"2022-11-30T17:15:52Z\"}} random-container-name"

```

## show resources requests for specific container in a statefulset

```
oc get pod -n asdf-blub-namespace -o json | jq '.items[].spec.containers[] | select(.name == "container-name") | .resources.requests'
```

## display node name and taints for each node in the cluster

```
$ kubectl get node -o json | jq '.items[] | (.spec.taints,.metadata.name)'
"a-node-big3-3.asdf.something.net"
[
  {
    "effect": "NoSchedule",
    "key": "storagetype",
    "value": "local-hdd"
  }
]
"a-node-big3-4.asdf.something.net"
[
  {
    "effect": "NoSchedule",
    "key": "storagetype",
    "value": "local-hdd"
  }
]
```

