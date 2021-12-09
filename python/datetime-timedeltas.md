# Python Timedeltas
```
import datetime
t0 = datetime.datetime.now()
dt = datetime.datetime.now() - t0
weeks = dt / datetime.timedelta(days=7)
hours = dt / datetime.timedelta(hours=1)

print('weeks: {}'.format(weeks))
print('hours: {}'.format(hours))
```
