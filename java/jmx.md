```yaml
services:
  artifactory:
    environment:
      EXTRA_JAVA_OPTIONS: "-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9010 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=localhost -Dcom.sun.management.jmxremote.rmi.port=9011 -Dcom.sun.management.jmxremote.local.only=false"
```

