# Debug git commands

* To trace commands run by git when running a command like `git clone` use the
  GIT_TRACE env var. `GIT_TRACE=1 git clone ...`
* Http tracing can be enabled with `GIT_CURL_VERBOSE=1`

So, you'd usually run:

```text
GIT_TRACE=1 GIT_CURL_VERBOSE=1  git clone https://...
```

