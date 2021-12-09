## check blackbox exporter annotations for a service
```
probe_http_status_code{job=~"blackbox-http.*",service=~".*(minio).*"}
```

