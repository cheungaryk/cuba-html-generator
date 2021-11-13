IMAGE_REPO=cheungaryk
IMAGE_NAME=cuba
IMAGE_TAG?=latest
IMAGE=$(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG)
DATE=$(shell date '+%A, %B %d, %Y')

.PHONY: build-image
build-image:
	earthly --build-arg date="$(DATE)" --build-arg image=$(IMAGE) +build-image

.PHONY: html-gen
html-gen:
	docker run -v $(PWD):/antora --rm -t $(IMAGE) docs-site/antora-playbook.yml

.PHONY: html-gen-local
html-gen-local:
	@echo "Please enter your password below as I need permission to move the UI bundle zip file to /usr/local."
	@sudo cp custom-ui-bundle/build/ui-bundle.zip /usr/local
	antora docs-site/antora-playbook.yml

# need to run `make html-gen` at least once prior to running this
.PHONY: run-local
run-local:
	npm i -g http-server
	http-server docs-site/build/site -c-1
