# Website to pdf

## by hand (deprecated)

* Save html as is -> <https://github.com/gildas-lormeau/SingleFile>
* Change layout via [local browser page](./website-to-pdf.html)
* print page -> save as PDF


## Paperoni & Calibre

* [fetch articles (writes links file)](../getpocket.md)
* [to epub](../website-to-epub)
* use calibre to convert an `epub` into a `pdf`

```text
brew install calibre

ebook-convert Spying\ on\ a\ Ruby\ process\'s\ memory\ allocations\ with\ eBPF.epub Spying\ on\ a\ Ruby\ process\'s\ memory\ allocations\ with\ eBPF.pdf
```

### batch conversion

```text
find . -name '*.epub' -exec sh -c 'b="$(basename "$0" | sed -r "s#\.epub\$#")"; ebook-convert "$0" "$b".pdf' {} \;
```
