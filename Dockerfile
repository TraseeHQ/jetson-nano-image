FROM multiarch/ubuntu-core:arm64-bionic
RUN apt-get update && apt-get install -y debootstrap build-essential python3-pip python3-setuptools coreutils iputils-ping parted wget gdisk e2fsprogs
RUN pip3 install ansible
RUN mkdir -p /build/rootfs
VOLUME /build
WORKDIR /build
ENV JETSON_ROOTFS_DIR=/tmp/rootfs
ENV JETSON_BUILD_DIR=/build

ENTRYPOINT [ "/bin/bash", "-l", "-c" ]

