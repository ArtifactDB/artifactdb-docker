import logging

from artifactdb.backend.app import get_app

from config import get_config
from backend.manager import BackendManager

app = get_app(config_provider=get_config,manager_class=BackendManager)
