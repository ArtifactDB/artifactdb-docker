import copy
import logging

from artifactdb.config import ArtifactDBConfigBase
from artifactdb.config.utils import get_config as get_config_func


class ApiConfig(ArtifactDBConfigBase):
    logo_url = "./static/adb-logo.png"


def get_config(config_file=None, env=None):
    return get_config_func(config_class=ApiConfig,config_file=config_file,env=env)
