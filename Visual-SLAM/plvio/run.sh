XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run -it \
    --volume=$XSOCK:$XSOCK:rw \
    --volume=$XAUTH:$XAUTH:rw \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="ROS_MASTER_URI=http://172.17.0.1:11311" \
    --env="ROS_IP=172.17.0.2" \
    --env="XAUTHORITY=${XAUTH}" \
    --env="DISPLAY" \
    hyeonjaegil/plvio:melodic \
    bash

    # --runtime=nvidia \
    # --env="QT_X11_NO_MITSHM=1" \