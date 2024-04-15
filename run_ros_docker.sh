#!/bin/sh
xhost +

workdir=/userdata/workdir

docker stop x86_ros
docker rm x86_ros
# -p 2222:22 \
# -v /usr/bin/qemu-aarch64-static:/usr/bin/qemu-aarch64-static \
docker run -it -d --privileged \
--name x86_ros \
-u root \
--userns=host \
-w /userdata/workdir \
-v $workdir:/userdata/workdir \
--device=/dev/dri --group-add video --volume=/tmp/.X11-unix:/tmp/.X11-unix  --env="DISPLAY=$DISPLAY" \
x86-ros:latest /bin/bash

docker ps
