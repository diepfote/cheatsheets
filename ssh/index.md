# SSH

## Command Line Options

* disable strict host checking

```
ssh -o StrictHostKeyChecking=no <...>
```

## ssh jump through bastion host first
```
ssh <user>@<ip address> -J <jump host ip>
```
More in the [gentoo wiki](https://wiki.gentoo.org/wiki/SSH_jump_host)

## ssh local port forward

Forward connections on IP to localhost via the host localhost 
via port 60906 (this is actually the lima vm).
Why? --> expose container in lima vm to local network of Mac.

```
ssh -p 60906 -NT -L 10.157.80.56:8080:localhost:8080  localhost
```

## ssh dynamic port forward | ssh socks5 proxy


```
# -D ... dynamic
# -T ... no pseudo terminal allocation
# -N ... do not execute remote command (just forward ports)
# -f ... in background
ssh -D 5555 -TN <ip-or-hostname> -f
```
