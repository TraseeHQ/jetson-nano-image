DOCKER ?= docker

help: ## Show this help
	@grep -E '^[.a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


build.builder-image: ## Build image builder docker container
	$(DOCKER) build -t jetson-img-builder .

run.qemu-static: ## Enable building ARM on x86-64
	$(DOCKER) run --rm --privileged multiarch/qemu-user-static:register

prepare.image-files: ## Create files necessary to save image
	sudo -E ./create-rootfs.sh
	cd ansible
	sudo -E ansible-playbook jetson.yaml
	cd ..
	sudo -E ./build-image.sh

build: run.qemu-static build.builder-image ## Create image files in builder container
	$(DOCKER) run --rm --privileged -it -v $(shell pwd):/jetson jetson-img-builder "make prepare.image-files"

save.image: ## Save image for flashing
	sudo ./save-image.sh
	
drive ?= CHANGEME
flash: ## Flash image to SD card
	sudo ./flash-image.sh build/jetson.img $(drive)

