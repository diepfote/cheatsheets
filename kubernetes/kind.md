# Kind - Kubernetes in Docker

## kind trust ssl inspecting proxy

Allow man in the middle proxy

```text
Failed to pull image "docker.io/istio/pilot:1.26.3": failed to pull and unpack image "docker.io/istio/pilot:1.26.3": failed to copy: httpReadSeeker: failed open: failed to do request: Get ...: tls: failed to verify certificate: x509: certificate signed by unknown authority
```


```text
# create cluster first
kind create cluster --name demo

# control plane node(s)
docker cp corp-proxy-ca.crt demo-control-plane:/usr/local/share/ca-certificates/corp-proxy-ca.crt
docker exec demo-control-plane update-ca-certificates

## worker nodes, if any
# docker cp corp-proxy-ca.crt demo-worker:/usr/local/share/ca-certificates/corp-proxy-ca.crt
# docker exec demo-worker update-ca-certificates
```

## kind load balancer

<https://github.com/kubernetes-sigs/cloud-provider-kind>


### installation

```text
go install sigs.k8s.io/cloud-provider-kind@latest
```

### usage

```text
export KUBECONFIG=~/.kube/kind && sudo cloud-provider-kind
```

