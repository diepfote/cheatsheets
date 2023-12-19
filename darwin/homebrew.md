# Homebrew

## install previous version of pkg

```text
cd "$(brew --repo homebrew/core)"

# find commit & reset to commit
git find-commits-changed-file -- Formula/poetry.rb
git reset --hard 1b9787d7c5

# build from source
brew install --build-from-source poetry

# reset homebrew repo
git fetch origin master
git reset --hard origin/master
```
