FROM tiangolo/uvicorn-gunicorn-fastapi:python3.9-alpine3.14

RUN apk --no-cache add git
ARG ADB_GITHASH
ARG ADB_GITBRANCH

WORKDIR /app
# anonymous pull
RUN git config --global url."https://".insteadOf git:// \
    && git config --global url."https://github.com/".insteadOf git@github.com: \
    && cat ~/.gitconfig
# git clone as root lib folder, since it contains submodules
RUN git clone --recurse-submodules --depth=1 -b $ADB_GITBRANCH https://github.com/ArtifactDB/artifactdb-docker.git lib \
    && cd lib \
    && git checkout $ADB_GITHASH

RUN \
    # install build & run dependencies
    apk --no-cache add sudo gcc musl-dev linux-headers bash py3-virtualenv git curl build-base postgresql-dev \
    && apk --no-cache add libmagic \
    && python -m pip install --upgrade pip 'ipython>=8.12.0' awscli==1.18.76 \
    # adb-*, develop mode to keep checked out code as the active version
    && cd /app/lib/artifactdb-identifiers \
    && python setup.py develop \
    && cd /app/lib/artifactdb-utils \
    && python setup.py develop \
    && cd /app/lib/artifactdb-backend \
    && python setup.py develop \
    # uninstall build deps and cache
    && rm -rf /root/.cache/pip \
    && apk del sudo gcc musl-dev linux-headers build-base postgresql-dev \
    # adjust run deps again
    && apk --no-cache add postgresql-libs libmagic

# install code for generic API itself
RUN find lib/src -maxdepth 1 -mindepth 1 -type d -exec ln -s {} \; \
    && ln -s lib/src/config.py

WORKDIR /app
ENV MODULE_NAME rest.main
ENV PORT 8000

EXPOSE 8000


