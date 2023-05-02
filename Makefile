ADB_GITBRANCH = $(shell git rev-parse --abbrev-ref HEAD)
ADB_GITHASH = $(shell git rev-parse --short HEAD)
BUILD_TAG = $(ADB_GITBRANCH)-$(ADB_GITHASH)

.build:
	docker build \
       --build-arg ADB_GITHASH=$(ADB_GITHASH) \
       --build-arg ADB_GITBRANCH=$(ADB_GITBRANCH) \
	   --tag artifactdb:$(BUILD_TAG) \
	   --file Dockerfile .

image: .build

image-local: .build

dev-push:
	# explicit hash for versioning
	docker tag \
      artifactdb:$(BUILD_TAG) \
      localhost:5000/artifactdb:$(BUILD_TAG)
	docker tag artifactdb:$(BUILD_TAG) \
      localhost:5000/artifactdb:latest
	docker push localhost:5000/artifactdb:$(BUILD_TAG)
	docker push localhost:5000/artifactdb:latest
