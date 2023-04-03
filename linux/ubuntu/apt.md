# Apt package installer

## configure a proxy for Apt

snatched from <https://askubuntu.com/questions/257290/configure-proxy-for-apt>

`/etc/apt/apt.conf`:

```
Acquire::http::Proxy "http://yourproxyaddress:proxyport";
```
