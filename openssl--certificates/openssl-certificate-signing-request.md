```
# certificate signing request (CSR)
$ openssl req -new \
              -key ~/Documents/kubernetes/etc/kubernetes/pki/apiserver-etcd-client.key \
              -subj '/CN=kube-apiserver-etcd-client/O=system:masters' \
              -out kube-apiserver-etcd-client.csr

# sign request (CRT)
$ openssl x509 -req \
               -in kube-apiserver-etcd-client.csr \
               -out kube-apiserver-etcd-client.crt \
               -CA ~/Documents/kubernetes/etc/kubernetes/pki/etcd/ca.crt \
               -CAkey ~/Documents/kubernetes/etc/kubernetes/pki/etcd/ca.key \
               -CAcreateserial \
               -days 30
Signature ok
subject=CN = kube-apiserver-etcd-client, O = system:masters
Getting CA Private Key


$ openssl x509 -in kube-apiserver-etcd-client.crt -noout -text
Certificate:
    Data:
        Version: 1 (0x0)
        Serial Number:
            f9:25:5a:6c:02:fa:f8:16
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN = etcd-ca
        Validity
            Not Before: Mar 28 11:00:03 2020 GMT
            Not After : Apr 27 11:00:03 2020 GMT
        Subject: CN = kube-apiserver-etcd-client, O = system:masters
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:a8:f3:da:ec:28:d6:13:5d:67:9a:34:18:b3:83:
                    25:90:a6:d2:18:13:8f:02:63:9c:23:20:80:a8:02:
                    dc:90:3e:23:75:29:ac:2c:d3:58:11:b1:e0:c7:2c:
                    3f:84:c2:22:f4:b5:84:c5:ce:e4:1d:fb:90:0d:43:
                    e6:fa:6a:44:4d:62:af:8b:c0:c4:d2:5d:2e:3c:02:
                    2a:6b:79:f5:d6:62:d5:3b:6c:53:bb:df:86:81:73:
                    db:14:9f:07:ca:8e:02:69:9f:43:f6:f6:0f:03:0e:
                    7e:e9:35:37:f8:1f:93:ad:68:b5:22:ac:cd:72:61:
                    32:02:42:48:14:74:77:e7:4d:cf:69:77:fc:91:62:
                    18:cf:8a:94:07:d0:31:2f:ee:09:43:f6:a7:48:23:
                    a1:a4:de:a4:21:48:1b:da:d6:48:6c:99:ee:09:a7:
                    0a:e9:6e:47:88:4f:07:4b:88:c2:f5:0c:88:25:49:
                    95:be:4c:a6:3e:27:75:60:25:52:89:a3:63:1d:75:
                    15:23:a2:01:22:e2:b2:f2:a2:79:9e:a3:bf:5c:98:
                    bf:72:ed:44:f6:62:40:96:8d:a2:ca:5e:0c:f7:d9:
                    d1:e8:59:46:0f:1d:6d:16:09:8f:4c:66:07:96:f7:
                    2d:84:53:19:e5:17:3a:e1:0b:ee:56:22:9e:fe:af:
                    9d:c7
                Exponent: 65537 (0x10001)
    Signature Algorithm: sha256WithRSAEncryption
         a1:d5:18:54:a7:9b:b0:e2:e7:5f:20:03:1a:a2:03:9d:10:e4:
         af:82:33:12:88:a8:2a:0a:53:46:6f:6d:65:e3:13:b8:ee:a0:
         37:1a:7b:7e:84:a5:45:0c:2a:65:19:f3:b7:00:ea:a8:91:0c:
         65:dc:bf:0b:67:9a:74:55:1b:91:68:6b:6d:d9:3a:55:69:e7:
         bf:78:c1:69:66:36:20:ba:a1:51:d3:9b:4a:8c:75:70:ce:e9:
         ca:91:b4:ec:65:9a:e2:0e:ae:06:87:9d:30:79:3e:fc:f9:60:
         0f:4f:7a:1f:fb:a1:f1:eb:c5:f4:ab:1a:d4:bb:e3:46:f3:e0:
         2c:20:ad:77:0a:64:e7:60:33:c0:dd:82:b0:70:25:4a:3d:e9:
         71:72:f1:8b:c9:c2:58:49:50:4f:b1:5a:4b:9e:de:e9:0a:b7:
         a3:c0:54:47:b6:e0:5b:af:15:a4:f8:17:3b:a7:60:21:09:8d:
         5b:4e:a7:5e:14:a4:6f:2a:d0:91:ee:39:f7:bb:89:04:e9:a0:
         00:c1:0d:4a:90:04:ef:3d:31:2e:7d:e5:54:cf:3d:14:a2:ba:
         ce:1d:3d:b8:1e:cd:cc:ba:1d:f5:fd:5e:86:c6:14:27:4d:f3:
         d2:5d:0f:69:c7:57:0c:e4:32:f4:9f:23:44:2e:ea:1a:d1:36:
         24:6a:dc:d4
```

