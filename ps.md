# PS command

## show command line column only
```
$ ps -eo args | grep -v grep | grep -E '^nvim'
nvim /Users/florian/Desktop/expressions.txt
nvim playbooks/training-2021-12-09.yaml
```
