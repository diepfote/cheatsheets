SHELL := bash

.PHONY: build
build:
	./.bin/local-build.sh

.PHONY: re-build-on-file-change
re-build-on-file-change:
	find -name '*.md' | entr make -r
