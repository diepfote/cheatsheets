# Virtualenvs

## Setup new virtualenv

```text
 rm -r ~/Library/Caches/pip; deactivate; rm -r .venv; virtualenv -p /usr/local/opt/python@3.9/bin/python3 .venv; source .venv/bin/activate
 rm -r ~/.cache/pip; deactivate; rm -r .venv; virtualenv -p python3 .venv; source .venv/bin/activate
```

## Pipfile to pyproject.toml | pipenv to poetry

```text
python3 -m pip install -U pipenv-poetry-migrate

pipenv-poetry-migrate -f Pipfile -t pyproject.toml
```

Add index server

```text
[tool.poetry.source]
name = "different-index-server"
url = "https://index-server"
default = true
```

## Use poetry for package management only

```text
[tool.poetry]
package-mode = false
```
