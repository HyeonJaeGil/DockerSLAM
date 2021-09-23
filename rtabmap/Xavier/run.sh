#!/bin/sh

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run -it \
    --env="DISPLAY=${DISPLAY}" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="ROS_MASTER_URI=http://172.17.0.1:11311" \
    --env="ROS_IP=172.17.0.2" \
    --volume=$XSOCK:$XSOCK:rw \
    --env="XAUTHORITY=${XAUTH}" \
    --volume="$XAUTH:$XAUTH" \
    --runtime=nvidia \
    hyeonjaegil/xavier:rtabmap \
    bash
