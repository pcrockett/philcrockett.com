IMG_NAME ?= website-env

ci:
	npm ci --prefer-offline
	npm run remark-lint
	npm run build
.PHONY: ci

devenv-ci: devenv-build
	docker run --rm \
		--volume .:/app \
		--user "$(shell id -u):$(shell id -g)" \
		"$(IMG_NAME)" \
		make ci
.PHONY: devenv-ci

devenv-shell: devenv-build
	docker run --rm -it \
		--volume .:/app \
		--user "$(shell id -u):$(shell id -g)" \
		"$(IMG_NAME)"
.PHONY: devenv

devenv-build:
	docker build \
		--build-arg "UID=$(shell id -u)" \
		--build-arg "GID=$(shell id -g)" \
		--build-arg "USERNAME=user" \
		--build-arg "HOME=/home/user" \
		--tag "$(IMG_NAME)" \
		.
.PHONY: devenv-build
