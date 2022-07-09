REGISTRY = localhost
NAME = sphinx-book
VERSION = latest
RUNTIME = docker

MAKEFILE_DIR = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

# @see https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.DEFAULT_GOAL := help
.PHONY: help
help: ## Display this self-documented help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: image
image: ## Build the Docker image.
	@echo "Building $(REGISTRY)/$(NAME):$(VERSION)"
	@$(RUNTIME) build \
		--build-arg VERSION=${VERSION} \
		--tag $(REGISTRY)/$(NAME):$(VERSION) \
		.

.PHONY: html
html: ## Build the HTML documentation.
	@$(RUNTIME) container run --rm \
		-v $(MAKEFILE_DIR):/docs:Z \
		$(REGISTRY)/$(NAME):$(VERSION) sphinx-build -b html /docs/src /docs/_build

.PHONY: clean
clean: ## Delete the HTML documentation.
	@rm -rf ./_build

