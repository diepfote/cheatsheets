import logging
import os
from functools import cache

LOG_LEVELS = {
    "debug": logging.DEBUG,
    "info": logging.INFO,
    "warn": logging.WARN,
    "error": logging.ERROR,
}


@cache
def get_logger():
    LOG_LEVEL = os.getenv("LOG_LEVEL", "debug")

    logger = logging.getLogger('whatever-you-want-to-name-this')
    logger.setLevel(logging.DEBUG)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    # console output
    ch = logging.StreamHandler()
    ch.setFormatter(formatter)
    ch.setLevel(LOG_LEVELS[LOG_LEVEL])
    logger.addHandler(ch)

    return logger
