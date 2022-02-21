# [Get Pocket](https://getpocket.com)

## Get RSS feed of unread articles (My-List)

API docs: https://help.getpocket.com/article/1074-can-i-subscribe-to-my-list-via-rss

```
curl -L -s -u "$(pass tail pocket | head -n1):$(pass pocket | head -n1)" "http://getpocket.com/users/$(pass tail pocket | head -n1)/feed/unread"  | grep -E '^<link>' | sed -r 's#</?link>##g' | tail -n +2
```
