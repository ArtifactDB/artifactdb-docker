import logging
from functools import partial

from artifactdb.backend.app import get_app, TASKS
from artifactdb.backend.tasks import task_params
from artifactdb.backend.managers import RETRYABLE_EXCEPTIONS

from config import get_config
from backend.manager import BackendManager


# Placeholder for event-based tasks
@task_params(bind=True,name="publish_event",autoretry_for=RETRYABLE_EXCEPTIONS,default_retry_delay=30)
def publish_event(self, project_id, stage, message, version=None, subject="", use_schema=True):
    logging.info("publish_event, placeholder")


@task_params(bind=True,name="open_log",autoretry_for=RETRYABLE_EXCEPTIONS,default_retry_delay=30)
def open_log(self, project_id, version=None, subject="", close_when=None, attrs_when_closed=None, use_schema=True):
    logging.info("open_log, placeholder")


@task_params(bind=True,name="append_log",autoretry_for=RETRYABLE_EXCEPTIONS,default_retry_delay=30)
def append_log(self, project_id, stage, message="", version=None, use_schema=True):
    logging.info("append_log, placeholder")


@task_params(bind=True,name="close_log",autoretry_for=RETRYABLE_EXCEPTIONS,default_retry_delay=30)
def close_log(self, project_id, version=None):
    logging.info("close_log, placeholder")


TASKS.extend([publish_event, open_log, append_log, close_log])
app = get_app(config_provider=get_config,manager_class=BackendManager,tasks=TASKS)
