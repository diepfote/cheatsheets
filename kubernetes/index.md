## run a pod with custom entrypoint and arguments
 | run a pod with custom command and arguments
 | run a pod with command and arguments

`$ kubectl apply -f create_s3_bucket_pod.yaml`

```
---
# Source: create_s3_bucket_pod.yaml

apiVersion: v1
kind: Pod
metadata:
  name: minio-client
  labels:
    purpose: create-minio-bucket
spec:
  containers:
  - name: minio-client
    image: minio/mc
    command: ["/bin/sh"]
    args: ["-c", "mc config host add kubernetes_minio http://helmtmpl-minio.velero.svc:9000 accessKey secretKey; mc mb kubernetes_minio/tinker"]
  restartPolicy: OnFailure
```


## delete all pods matching a prefix or suffix

```
$ for "$name" in $(kubectl get -o name pod); do
    case "$name" in *<pre/suf-fix>*)
      kubectl delete  "$name" & ;;
    esac

  done
```


## delete a resource immediately

`$ kubectl delete ... --force --grace-period=0`



## filter all resources

```
$ kubectl get all -l bu=finance env=prod
$ kubectl get all --selector bu=finance env=prod
```

## get field in kubernetes object hierarchy

```
$ kubectl fields pod volumeMounts
spec.containers.volumeMounts
spec.initContainers.volumeMounts

$ kubectl fields pod imagepullsecrets
spec.imagePullSecrets

$ kubectl fields pod toleration
spec.tolerations
spec.tolerations.tolerationSeconds
```

## Show sub-resources of Kubernetes objects

```
$ kubectl tree -n bli-bla-blub sts asdf
NAMESPACE    NAME                                       READY  REASON  AGE
bli-bla-blub  StatefulSet/asdf                      -              2y108d
bli-bla-blub  ├─ControllerRevision/asdf-546c9d8dfb  -              57d
bli-bla-blub  ├─ControllerRevision/asdf-567f88c999  -              15d
bli-bla-blub  ├─ControllerRevision/asdf-5c65886648  -              355d
bli-bla-blub  ├─ControllerRevision/asdf-5d49fc656f  -              285d
bli-bla-blub  ├─ControllerRevision/asdf-5dc54bfc6b  -              6d19h
bli-bla-blub  ├─ControllerRevision/asdf-664488d4bc  -              112d
bli-bla-blub  ├─ControllerRevision/asdf-694dd575fd  -              6d12h
bli-bla-blub  ├─ControllerRevision/asdf-69f55d649d  -              2y108d
bli-bla-blub  ├─ControllerRevision/asdf-6bcfd4cd95  -              12d
bli-bla-blub  ├─ControllerRevision/asdf-6d7c8c6d56  -              723d
bli-bla-blub  ├─ControllerRevision/asdf-977f785cf   -              284d
bli-bla-blub  ├─Pod/asdf-0                          True           15h
bli-bla-blub  └─Pod/asdf-1                          True           14h
```

## Sort pods

```
$ oc get pod -l app=openam -n blib-bla-name --sort-by=.status.startTime
NAME                                         READY   STATUS    RESTARTS   AGE
blib-bla-name-openam-openam-59876b476d-pf9lz   1/1     Running   0          11h
blib-bla-name-openam-openam-59876b476d-ztl2n   1/1     Running   0          4m
blib-bla-name-openam-openam-59876b476d-qbfsb   1/1     Running   0          1m
```

## Delete oldest pod
$ oc delete -n blib-bla-name "$(oc get pod -l app=openam -n blib-bla-name --sort-by=.status.startTime -o name | head -n1)"
pod "blib-bla-name-openam-openam-59876b476d-pf9lz" deleted
