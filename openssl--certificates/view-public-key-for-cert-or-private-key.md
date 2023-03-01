```
# extract public key from CRT
$ openssl x509 -in servicedesk-ca-cert1.crt -noout -pubkey


# extract public key from private key
$ openssl rsa -in servicedesk.key -pubout

```
