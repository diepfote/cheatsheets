## Website to pdf

### by hand (deprecated)
* Save html as is -> https://github.com/gildas-lormeau/SingleFile
* Change layout via [local browser page](./website-to-pdf.html)
* print page -> save as PDF


### Paperoni & Calibre

* [to epub](#website-to-epub)
* use calibre to convert an `epub` into a `pdf`
  ```
  brew install calibre

  ebook-convert Spying\ on\ a\ Ruby\ process\'s\ memory\ allocations\ with\ eBPF.epub Spying\ on\ a\ Ruby\ process\'s\ memory\ allocations\ with\ eBPF.pdf
  ```

#### batch conversion

```
find . -name '*.epub' -exec sh -c 'b="$(basename "$0" | sed -r "s#\.epub\$##")"; ebook-convert "$0" "$b".pdf' {} \;
```


## Website to epub

* Install paperoni via cargo.  
  Check [Paperoni](https://lib.rs/crates/paperoni) for installation instructions.
* run paperoni
  ```
  $ paperoni -o /tmp 'https://jvns.ca/blog/2018/01/31/spying-on-a-ruby-process-s-memory-allocations/'
  Downloading article to /tmp
    [00:00:00] ████████████████████████████████████████  link 1/1       Downloaded articles
    [00:00:00] ████████████████████████████████████████  epub 1/1       Generated epubs

  Article downloaded successfully
  ─────────────────────────────────────────────────────────
                     Downloaded articles
  ═════════════════════════════════════════════════════════
   Spying on a Ruby process's memory allocations with eBPF
  ────────────────────────────────────────────────────────
  ```

