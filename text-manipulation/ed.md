# Ed text editor | vim's built-in regex engine

## remove lines containing a pattern

```text
ed ~/.npmrc < <(echo 'g/subdomain.domain.some.where/d'; echo w)
```
