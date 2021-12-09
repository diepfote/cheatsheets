# Re-bind PV | Rebind PV | PVC stuck in "Pending" state

MOST IMPORTANT:
* remove claimRef

also remove:

* resourceVersion
* creationTimestamp
* selflink
* metadata.annotations

DO NOT REMOVE THE `uid` of the pv resource


so entire procedure:

* set pv to reclaimpolicy retain
* delete pvc
* edit pv ^ (claimref etc.)
* re-deploy pvc without
 * annotations
  * verlero labels
