# Prometheus

## check max of metric in timeframe

nicked from <https://utcc.utoronto.ca/~cks/space/blog/sysadmin/PrometheusTimestampExpressions>

```
max_over_time ( ( timestamp( the_metric < VALUE ) ) [LOOK_BACK_X:RESOLUTION] )
max_over_time ( ( timestamp( the_metric < 22 ) ) [90d:1m] )
```

## check blackbox exporter annotations for a service

```
probe_http_status_code{job=~"blackbox-http.*",service=~".*(minio).*"}
```

