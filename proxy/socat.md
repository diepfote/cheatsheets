# SOCAT

## TCP port forwarder
```
  socat TCP4-LISTEN:9999 tcp4:www.google.com:80 &

  curl -H Host:google.com -v localhost:9999/index.html
```
