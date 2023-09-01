import importlib
logger = importlib.import_module('logger')
logger = logger.get_logger()


logger.info('something you want to log')
