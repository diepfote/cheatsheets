import logging
import os
# if we return a logger per loading this module we will log multiple times
from functools import cache


LOG_LEVELS = {
    "debug": logging.DEBUG,
    "info": logging.INFO,
    "warn": logging.WARN,
    "error": logging.ERROR,
}


@cache
def get_logger():
    log_level = os.getenv("LOG_LEVEL", "debug")
    log_level = LOG_LEVELS[log_level]

    logger = logging.getLogger('whatever-you-want-to-name-this')
    logger.setLevel(logging.DEBUG)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    # console output
    ch = logging.StreamHandler()
    ch.setFormatter(formatter)
    ch.setLevel(log_level)
    logger.addHandler(ch)

    return logger
