# Apache

## Block request | RewriteRule | RewriteCond

* RewriteRule Flags: <https://httpd.apache.org/docs/2.4/rewrite/flags.html>
* RewriteCond etc.: <https://httpd.apache.org/docs/2.4/rewrite/remapping.html>

Rewrite commands ignore location blocks although you may put these commands
inside locations blocks (not ignored if in a VirtualHost).  
Be sure to filter the URI path so it applies to the same path as the location block.


```text
<Location /a-path-of-sorts>
RewriteCond %{REQUEST_URI} ^/a-path-of-sorts/.*asdf.*$
# "-" -> do not rewrite request (pass back as is)
# "F" -> Forbidden
# "L" -> stop processing more rules
RewriteRule ^.*$ - [F,L]
</Location>
```

Hints:

* Always use beginning and end markers in RequestCond regex.
* Multiple RewriteCond are allowed. They have to directly preceed
a RewriteRule to apply to it.
