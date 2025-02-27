IMG_NAME ?= website-env

ci:
	npm ci --prefer-offline
	npm run remark-lint
	npm run build
.PHONY: ci

devenv-ci: devenv-build
	docker run --rm --volume .:/app "$(IMG_NAME)" make ci
.PHONY: devenv-ci

devenv-shell: devenv-build
	docker run --rm -it --volume .:/app "$(IMG_NAME)"
.PHONY: devenv

devenv-build:
	docker build --tag "$(IMG_NAME)" .
.PHONY: devenv-build
