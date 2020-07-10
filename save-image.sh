#!/bin/bash

# Check if the user is not root
if [ "x$(whoami)" != "xroot" ]; then
        printf "\e[31mThis script requires root privilege\e[0m\n"
        exit 1
fi

printf "Create image...       "
rootfs_size=$(du -hsBM build/rootfs | awk '{print $1}')
rootfs_size=$(echo $((${rootfs_size%?} + 200))"M")
cd build
./create-jetson-nano-sd-card-image.sh -o jetson.img -s $rootfs_size -r 200
printf "OK\n"
printf "Image location: $(pwd)/jetson.img\n"
