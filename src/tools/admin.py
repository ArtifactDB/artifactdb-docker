from backend.manager import BackendManager
import config

cfg = config.get_config()
mgr = BackendManager(cfg)
# import tools/admin helpers
from artifactdb.tools.admin import *

