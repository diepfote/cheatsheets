# Proxy

## Ha Proxy - HAProxy

### docs
https://cbonte.github.io/haproxy-dconv/
https://www.haproxy.com/documentation/aloha/9-5/traffic-management/lb-layer7/http-rewrite/
https://wiki.archlinux.org/index.php/HAproxy

### redirect to abitrary url
```
backend training

        http-request redirect location http://wiki.archlinux.org
```

### check url path beginning - check url path end
```
frontend somename
    acl training_path path_beg -i /training
    acl training_path_all_the_way path_end -i /training

    # to AND rules specify them back to back
    use_backend test_redirect if training_path training_path_all_the_way acl_github_1
```


