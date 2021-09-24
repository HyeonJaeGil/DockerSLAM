#!/bin/sh

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run --rm -it \
    --env="DISPLAY=${DISPLAY}" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="TERM=xterm-256color" \
    --env="ROS_MASTER_URI=http://172.17.0.1:11311" \
    --env="ROS_IP=172.17.0.1" \
    --volume=$XSOCK:$XSOCK:rw \
    --volume=/usr/lib/aarch64-linux-gnu/tegra:/usr/lib/aarch64-linux-gnu/tegra \
    --volume=/usr/lib/aarch64-linux-gnu/tegra-egl:/usr/lib/aarch64-linux-gnu/tegra-egl \
    --env="XAUTHORITY=${XAUTH}" \
    --volume="$XAUTH:$XAUTH" \
    --runtime=nvidia \
    --net=host \
    --env=TERM=xterm-256color \
    jetson/rtabmap:ros \
    bash

    # hyeonjaegil/xavier:rtabmap \
