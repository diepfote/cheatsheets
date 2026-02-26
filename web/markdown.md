# Markdown

## Generate Table of Contents

[`build-container-image` helper](https://github.com/diepfote/dockerfiles/blob/1c2161a0eb6684516015cfddf2f81db2c4552dcc/bin/build-container-image) to build the image

```text
build-container-image markdown-toc
```

--

To run it check the README [here](https://github.com/diepfote/dockerfiles/tree/master/markdown-toc)


## Markdownlint - Lint markdown

A [dependency](https://www.npmjs.com/package/markdownlint) for [coc-markdownlint](https://github.com/fannheyward/coc-markdownlint/blob/master/package.json).

You can install the [cli package](https://github.com/igorshubovych/markdownlint-cli) or use the docker image:

```text
docker run -v "$PWD":/workdir ghcr.io/igorshubovych/markdownlint-cli:latest "**/*.md"
```

