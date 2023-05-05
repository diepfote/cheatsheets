# OKD etcd

## curl etcd metrics | check etcd metrics

```
sudo etcdctl --ca-file=/etc/etcd/ca.crt --cert-file=/etc/etcd/peer.crt --key-file=/etc/etcd/peer.key -endpoints https://<endpoint-ip>:2379 cluster-health

etcdctl ... curl
--ca-file ... --cacert
--cert-file ... --cert client cert to use
--key-file ... --key  <path> --key-type <PEM-is-assumed>

# elevate privileges to read files in `/etc/etcd`
sudo curl -L -v --cacert /etc/etcd/ca.crt --cert /etc/etcd/peer.crt --key /etc/etcd/peer.key https://<endpoint-ip>:2379/metrics
```
