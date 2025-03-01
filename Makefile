IMG_NAME ?= website-env
UID ?= $(shell id -u)
GID ?= $(shell id -g)

ci: lint build
.PHONY: ci

build: deps
	./node_modules/.bin/eleventy
.PHONY: build

serve: deps
	./node_modules/.bin/eleventy --serve
.PHONY: serve

clean:
	rm -rf _site
.PHONY: clean

lint: deps
	./node_modules/.bin/remark . --frail --quiet
.PHONY: lint

format: deps
	./bin/md-format
.PHONY: format

deps: node_modules/.bin/eleventy
.PHONY: deps

node_modules/.bin/eleventy: package.json package-lock.json
	npm ci --prefer-offline

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
