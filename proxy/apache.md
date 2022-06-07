# Apache

## Block request | RewriteRule | RewriteCond

RewriteRule Flags: https://httpd.apache.org/docs/2.4/rewrite/flags.html
RewriteCond etc.: https://httpd.apache.org/docs/2.4/rewrite/remapping.html

Rewrite commands ignore location blocks although you may put these commands
inside locations blocks. Be sure to filter the URI path to apply to the
same location block you want it to apply to.
Always use beginning and end markers in RequestCond regex.
Multiple RewriteCond are allowed. They have to directly preceed a RewriteRule 
to apply to it.

```
<Location /a-path-of-sorts>
RewriteCond %{REQUEST_URI} ^/a-path-of-sorts/.*asdf.*$
# "-" -> do not rewrite request (pass back as is)
# "F" -> Forbidden
# "L" -> stop processing more rules
RewriteRule ^.*$ - [F,L]
</Location>
```
