# [Get Pocket](https://getpocket.com)
## Get RSS feed of articles

curl -L -s -u "$(pass tail pocket | head -n1):$(pass pocket | head -n1)" "http://getpocket.com/users/$(pass tail pocket | head -n1)/feed/unread"  | grep -E '^<link>' | sed -r 's#</?link>##g' | tail -n +2

