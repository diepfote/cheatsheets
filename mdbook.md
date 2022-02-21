## mdbook

### to pdf

1) installation

https://crates.io/crates/mdbook-pdf

```
cargo install mdbook-pdf
```

2) add the following to the bottom of `book.toml`:

```

[output.pdf]
```

3) re-run mdbook build

```
mdbook build
```


### to epub

1) installation

https://crates.io/crates/mdbook-epub

```
cargo install mdbook-epub
```

2) standaleone run

```
mdbook-epub --standalone ./path/to/book/dir
```


