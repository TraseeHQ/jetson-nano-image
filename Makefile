DOCKER ?= docker

build.builder-image:
	$(DOCKER) build -t jetson-img-builder .

run.qemu-static:
	$(DOCKER) run --rm --privileged multiarch/qemu-user-static:register

build.image:
	./create-rootfs.sh
	cd ansible
	ansible-playbook jetson.yaml
	cd ..
	./create-image.sh

build: run.qemu-static build.builder-image
	mkdir build || true
	$(DOCKER) run --rm --privileged -it -v $(shell pwd):/build jetson-img-builder "make build.image"
