# DNS

## negative performance impact of `ndots:N`

*This is a short form of [the original](https://pracucci.com/kubernetes-dns-resolution-ndots-options-and-why-it-may-affect-application-performances.html)*


If traffic is external and there are several lookup domains `ndots:N` will cause
high amounts of DNS traffic before domains are resolved correctly.

`ndots:5` will result in 4 local lookups for this example config:

```text
# /etc/resolv.conf
nameserver 100.64.0.10
search namespace.svc.cluster.local svc.cluster.local cluster.local
```
