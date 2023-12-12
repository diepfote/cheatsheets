# Website to epub

* Install paperoni via cargo.  
  Check [Paperoni](<https://lib.rs/crates/paperoni>) for installation instructions.

* run paperoni

  * Single file

    ```text
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

  * Batch file

    ```text
    paperoni -o <output-dir> -f <file-containing-links>
    ```

    ```txet
    $ paperoni -o /tmp/paperoni-out/ -f /tmp/links.txt
    Downloading articles to /tmp/paperoni-out/
      [00:00:01] ████████████████████████████████████████  link 2/2       Downloaded articles
      [00:00:00] ████████████████████████████████████████  epub 2/2       Generated epubs

    All articles downloaded successfully
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
                                                      Downloaded articles
    ══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
     Lorem ipsum
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
     Aasdf
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ```

