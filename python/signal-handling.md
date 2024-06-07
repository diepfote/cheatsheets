# Python Signal Handling

Taken from <https://docs.python.org/3/library/signal.html>

Sidenote: Do not put this in a file called `signal.py`. Otherwise we override the module name.
The following will happen (<https://stackoverflow.com/a/66055075>):

  ```text
  $ python /tmp/signal.py
  Traceback (most recent call last):
    File "/tmp/signal.py", line 2, in <module>
      import signal
    File "/private/tmp/signal.py", line 3, in <module>
      from signal import SIGINT
  ImportError: cannot import name 'SIGINT' from partially initialized module 'signal' (most likely due to a circular import) (/private/tmp/signal.py)
  ```

```text
import time
import signal


def sigterm_handler(signal_num, stack_frame):
    '''Default kill signal | Graceful termination'''
    print('Terminating')
    exit(0)

def sigint_handler(signal_num, stack_frame):
    '''If someone presses ctrl-c'''
    print("Ctrl-C'ed by user.")
    exit(0)

def run_default_behavior(signal_num=None, stack_frame=None):
    print('main() executting')
    while True:
        print('still main()')
        time.sleep(2)

def wait_on_signal(signal_num=None, stack_frame=None):
    print('pausing')
    signal.pause()


signal.signal(signal.SIGTERM, sigterm_handler)
signal.signal(signal.SIGINT, sigint_handler)
signal.signal(signal.SIGUSR1, run_default_behavior)
signal.signal(signal.SIGUSR2, wait_on_signal)

run_default_behavior()
```


Triggering it

```text
$ kill -SIGUSR2 "$(ps -ef | grep -v grep | grep python | grep signal_test | awk '{ print $2 }')"
$ kill -SIGUSR1 "$(ps -ef | grep -v grep | grep python | grep signal_test | awk '{ print $2 }')"

# graceful termination
$ kill "$(ps -ef | grep -v grep | grep python | grep signal_test | awk '{ print $2 }')" 
$ kill -SIGTERM"$(ps -ef | grep -v grep | grep python | grep signal_test | awk '{ print $2 }')" 


# or ctrl-c
$ kill -SIGINT "$(ps -ef | grep -v grep | grep python | grep signal_test | awk '{ print $2 }')" 
```


Output

```text
$ python /tmp/signal_test.py
Still running...
pausing
running sync
Still running...
Still running...
SIGTERM received exiting
$ python /tmp/signal_test.py
SIGINT received exiting
```
