# Python Datetime

## python datetime and time zones

Use datetime with timezones to calculate a delta

```text
import math
import pytz
from datetime import datetime

tz = pytz.timezone('Europe/Vienna')
now = datetime.now(tz=tz)
point_in_time = datetime(now.year, now.month, now.day+1, 6, 0, 0, tzinfo=tz)
delta = int(math.fabs((point_in_time - now).total_seconds()))
print(f'delta: {delta} seconds')
```
