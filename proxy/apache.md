# Apache

## Block request | RewriteRule | RewriteCond

Rewrite commands ignore location blocks although you may put these commands
inside locations blocks. Be sure to filter the URI path to apply to the
same location block you want it to apply to.
Always use beginning and end markers in RequestCond regex.

```
<Location /a-path-of-sorts>
RewriteCond %{REQUEST_URI} ^/a-path-of-sorts/.*asdf.*$
# "-" -> do not rewrite request (pass back as is)
# "F" -> Forbidden
# "L" -> stop processing more rules
RewriteRule ^.*$ - [F,L]
</Location>
```
