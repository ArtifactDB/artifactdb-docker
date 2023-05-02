from artifactdb.rest.app import ArtifactDBApi

# set environment and dependencies before resources are set up
from rest.dependencies import DependencyManager
from config import get_config
from backend.app import app as celery_app
cfg = get_config()
mgr = DependencyManager(cfg=cfg,celery_app=celery_app)

app = ArtifactDBApi(title=cfg.name or "ArtifactDB",cfg=cfg,dependency_manager=mgr)

