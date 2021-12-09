# OKD SCC

## openshift add security context constraint to user 
`oc adm policy add-scc-to-user privileged -z <service-account>`

exchange privileged with something less forceful if possible:
  - anyuid
  - nonroot

## openshift remove scc for user
`oc adm policy remove-scc-from privileged -z <service-account>`

## openshift get scc for namespace (security context constraints are namespaced)

```
$ oc get scc -n cc-prod-servicedesk
NAME                       PRIV    CAPS                 SELINUX     RUNASUSER          FSGROUP     SUPGROUP    PRIORITY   READONLYROOTFS   VOLUMES
anyuid                     false   []                   MustRunAs   RunAsAny           RunAsAny    RunAsAny    10         false            [configMap downwardAPI emptyDir persistentVolumeClaim projected secret]
hostaccess
```

## openshift get clusterrole corresponding to scc

```
$ oc get clusterrole.rbac.authorization.k8s.io system:openshift:scc:nonroot -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: system:openshift:scc:nonroot
rules:
- apiGroups:
  - security.openshift.io
  resourceNames:
  - nonroot
  resources:
  - securitycontextconstraints
  verbs:
  - use
```

