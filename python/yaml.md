# Python Yaml module

## Load yaml from string

partially snatched from <https://stackoverflow.com/a/21843713>

```text
from io import StringIO
import yaml

yaml_ = "some:\n  - list element 1\n  - list element 2"
with StringIO(yaml_) as as_stream:
   as_dict = yaml.safe_load(as_stream) 

print(as_dict)
```

## Dict to yaml string

```text
import yaml

as_dict = {'some': ['list element 1', 'list element 2']}
a_string_again = yaml.dump(as_dict)
print(a_string_again)
```

