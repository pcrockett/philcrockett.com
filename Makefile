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

lint: deps
	./node_modules/.bin/remark . --frail --quiet
.PHONY: lint

format: deps
	./bin/md-format
.PHONY: format

clean:
	rm -rf _site
	git worktree prune
	rm -rf .git/worktrees/_site
.PHONY: clean

publish: worktree
	./bin/dirty-check
	rm -r _site/*
	make build
	cd _site
	git add --all
	git commit -m "Publish to gh-pages"
	@echo "Use \`git push --all\` to publish!"
.PHONY: publish

worktree: clean
	git worktree add -B gh-pages _site origin/gh-pages
.PHONY: worktree

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
