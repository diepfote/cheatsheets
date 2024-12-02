from datetime import datetime, timezone
from enum import Enum
import getopt
import sys
import traceback


# in spite of https://peps.python.org/pep-0389/


# Example:
# $ python .../getopt/main.py --log-path-prefix /tmp/something --folder /else --state-file /j3434.txt --include 'adsf.*' --include '.*blub' --exclude 'miau.*'
# parsing arguments
# argparse includes: ['adsf.*', '.*blub']
# argparse excludes: ['miau.*']
# log_filename: /tmp/something-2024-12-02T05.45.53Z.log
# folder: /else
# state_file: /j3434.txt


class ExitCode(Enum):
    GET_OPT_ERROR = 1
    LOG_PATH_PREFIX_UNSET = 2
    INVALID_OPT_OR_FLAG = 3
    SUCCESS = 0


def get_timestamp():
    return datetime.now(timezone.utc).strftime("%Y-%m-%dT%H.%M.%SZ")


def usage(additional_text=''):
    text = f'Usage: __main__.py --log-path-prefix /path/to/log/JOBNAME [--folder FOLDER] [--state-file STATE_FILE] [--include REGEX ...] [--exclude REGEX ...]\n{additional_text}'
    print(text, file=sys.stderr)


def argparse(args):
    print('parsing arguments', file=sys.stderr)

    log_path_prefix = None
    log_filename = None
    includes_override=False

    # defaults
    includes=['.*']
    excludes=[]
    folder = '/somewhere'
    state_file = '/mount/state.json'
    dry_run = False

    try:
        opts, args = getopt.getopt(args, "h", ["help", "dry-run", "include=", "exclude=", 'log-path-prefix=', 'state-file=', 'folder='])
        for opt, arg in opts:
            match opt:
                case '-h' | '--help':
                    usage()
                    exit(0)
                case '--dry-run':
                    dry_run = True
                case '--include':
                    # override default includes
                    if not includes_override:
                        includes = []
                        includes_override = True

                    includes.append(arg)
                case '--exclude':
                    excludes.append(arg)
                case '--log-path-prefix':
                    # e.g. /var/gerrit/gc_logs/jgit-default-j34udf
                    # we then append -<timestamp>.log below
                    log_path_prefix = arg
                    ts = get_timestamp()

                    log_filename = f'{log_path_prefix}-{ts}.log'
                case '--folder':
                    # '/var/gerrit/git/' or '/var/gerrit/git' -> '/var/gerrit/git'
                    folder = arg.rstrip('/')
                case '--state-file':
                    state_file = arg
                case _:
                    usage(f'Invalid flag or option: {opt}')
                    exit(ExitCode.INVALID_OPT_OR_FLAG)
    except getopt.GetoptError as error:
        print(error, file=sys.stderr)
        usage()
        exit(ExitCode.GET_OPT_ERROR)

    if log_path_prefix is None:
        usage('log_path_prefix is empty.')
        exit(ExitCode.LOG_PATH_PREFIX_UNSET)


    print('argparse includes: %s' % includes, file=sys.stderr)
    print('argparse excludes: %s' % excludes, file=sys.stderr)
    print('log_filename: %s' % log_filename, file=sys.stderr)
    print('folder: %s' % folder, file=sys.stderr)
    print('state_file: %s' % state_file, file=sys.stderr)
    return includes, excludes, dry_run, folder, state_file, log_filename


def print_traceback():
    print('main aborted: error: %s' % traceback.format_exc(), file=sys.stderr)


def main(args):
    includes, excludes, dry_run, folder, state_file, log_filename = argparse(args)

    # ...

try:
    main(sys.argv[1:])
except KeyboardInterrupt:
    exit(0)
except SystemExit as e:
    exit_code = e.code
    if exit_code != 0:
        print_traceback()
except:
    print_traceback()
