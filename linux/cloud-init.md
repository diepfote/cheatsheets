# Cloud-init

## How to disable ipv4 on ubuntu

`/etc/cloud/cloud.cfg.d/99-custom-network.cfg`:

```
cat << 'EOF'
network:
  version: 2
  ethernets:
    ens64:
      dhcp4: false
      dhcp6: true
      accept-ra: true
EOF
```

