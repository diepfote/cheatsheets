# Python Datetime

```text
import math
import pytz  # external dependency
from datetime import datetime
tz = pytz.timezone('Europe/Vienna')
now = datetime.now(tz=tz)
lifespan = "30y"
years = int(duration_str[:-1])
point_in_time = datetime(now.year+years, now.month, now.day, 6, 0, 0, tzinfo=tz)
delta = int(math.fabs((point_in_time - now).total_seconds()))
print(f'delta: {delta} seconds')
```
