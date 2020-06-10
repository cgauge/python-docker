VERSION_DIRS:=$(wildcard ?.?)
DOCKERFILES:=$(addsuffix /Dockerfile, $(VERSION_DIRS))
IMAGES:=$(addsuffix /image, $(VERSION_DIRS))
TESTS:=$(addsuffix /test, $(VERSION_DIRS))

.DEFAULT_GOAL:=help
.PHONY: dockerfiles images tests

# https://blog.thapaliya.com/posts/well-documented-makefiles/
help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  $(MAKE) \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

dockerfiles: $(DOCKERFILES) ## Renders all the Dockerfiles.

images: $(IMAGES) ## Builds all the images.

tests: $(TESTS) ## Checks if the Python version is correct in every image.

# Render the Dockerfile for a specific version.
%/Dockerfile: Dockerfile.mustache
	@echo "Rendering $@"
	echo "version: $(subst /,,$(dir $@))" | docker run --interactive --rm --volume=$(PWD):/src --workdir=/src toolbelt/mustache - Dockerfile.mustache > $@

# Build the image for a specific version.
%/image: VERSION=$(subst /,,$(dir $@))
%/image: IMAGE=customergauge/python3:$(VERSION)
%/image: %/Dockerfile
	docker build $(VERSION) --tag $(IMAGE)

# Run the test for a specific version.
%/test: VERSION=$(subst /,,$(dir $@))
%/test: IMAGE=customergauge/python3:$(VERSION)
%/test: IMAGE_PYTHON_VERSION=$(shell docker run --rm $(IMAGE) python -c 'import sys; print(str(sys.version_info[0])+"."+str(sys.version_info[1]))')
%/test: %/image
	@if [ "$(IMAGE_PYTHON_VERSION)" = "$(VERSION)" ]; then echo 'Python version $(VERSION) is correct.'; else echo 'Python version $(IMAGE_PYTHON_VERSION) in image does not match expected version $(VERSION).'; exit 1; fi
	@echo 'Checking if Pip is there'
	docker run -it --rm $(IMAGE) pip --version