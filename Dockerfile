FROM multiarch/ubuntu-core:arm64-bionic
RUN apt-get update && apt-get install -y debootstrap build-essential python python3-pip python3-setuptools coreutils parted wget gdisk e2fsprogs lbzip2 sudo cmake udev
RUN pip3 install ansible
RUN mkdir -p /build/rootfs
VOLUME /jetson
WORKDIR /jetson
ENV JETSON_ROOTFS_DIR=/srv/rootfs
ENV JETSON_BUILD_DIR=/srv/build

ENTRYPOINT [ "/bin/bash", "-l", "-c" ]

