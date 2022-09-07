# logging

taken from https://docs.python.org/3/howto/logging-cookbook.html#logging-cookbook &
           https://stackoverflow.com/a/6386764

```
import logging
logger = logging.getLogger('migration-sync')
logger.setLevel(logging.DEBUG)

formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
fh = logging.FileHandler('/tmp/some.log')
fh.setFormatter(formatter)
fh.setLevel(logging.DEBUG)

# console output
ch = logging.StreamHandler()
ch.setLevel(logging.INFO)

logger.addHandler(ch)
logger.addHandler(fh)

logger.debug('testing 1 2')
logger.info('testing 3 4')
```
