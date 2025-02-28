IMG_NAME ?= website-env
UID ?= $(shell id -u)
GID ?= $(shell id -g)

ci:
	npm ci --prefer-offline
	npm run remark-lint
	npm run build
.PHONY: ci

devenv-ci: devenv-build
	docker run --rm \
		--volume .:/app \
		--user "$(UID):$(GID)" \
		"$(IMG_NAME)" \
		make ci
.PHONY: devenv-ci

devenv-shell: devenv-build
	docker run --rm -it \
		--volume .:/app \
		--user "$(UID):$(GID)" \
		"$(IMG_NAME)"
.PHONY: devenv

devenv-build:
	docker build \
		--build-arg "UID=$(UID)" \
		--build-arg "GID=$(GID)" \
		--tag "$(IMG_NAME)" \
		.
.PHONY: devenv-build
