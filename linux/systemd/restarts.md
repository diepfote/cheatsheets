# Systemd unit restarts

## Exponential backoff/back-off and restart on failure

```text
commit 9e5b677a0cee185efb2518ca1c34294987080863
Author: noone <no@where>
Date:   Sun Feb 15 16:09:56 2026 +0000

    `nftables`: Add exponential backoff and restart on failure

diff --git a/nftables.service b/nftables.service
index 464d8df..97c151e 100644
--- a/nftables.service
+++ b/nftables.service
@@ -5,7 +5,10 @@ Wants=network-pre.target
 Before=network-pre.target
 
 [Service]
-Type=oneshot
+Restart=on-failure
+RestartSec=1s
+RestartSteps=5
+RestartMaxDelaySec=10s
 ExecStart=/usr/bin/nft -f /etc/nftables.conf
 
 [Install]
```
