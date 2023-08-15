# ArtifactDB Docker

This repo provides build instructions for a docker image that can be used to deploy a instance of ArtifactDB, ie. backend/api.
The image itself can be:
- used as-is to run a vanilla instance, without any customizations. The app/api code used can be found under `src` folder.
- used as base image for instance requiring custom logic (eg. custom REST API endpoints, custom backend tasks, etc...). Such a customize
  instance would then provide the equivalent of the `src` folder, overriding eg. manager classes, configuration sections, etc...


### Git submodules

This project uses the following Git submodules to calculate version hashes:

- [`libs/artifactdb-utils`](https://github.com/artifactdb/artifactdb-utils.git)
- [`libs/artifactdb-identifiers`](https://github.com/artifactdb/artifactdb-identifiers.git)
- [`libs/artifactdb-backend`](https://code.roche.com/artifactdb/artifactdb-backend.git)

To clone this repository with the submodules, use the following command:

```shell
$ git clone --recurse-submodules git@github.com:ArtifactDB/artifactdb-docker.git
```

If you have already cloned the repository without the submodules, you can initialize them with the following command:

```shell
$ git submodule update --init
```


### Building the image

`make image` should do the trick, while `make push` will push the image in the ghcr repo.
