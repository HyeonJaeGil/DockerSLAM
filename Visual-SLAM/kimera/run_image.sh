XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

xhost +local:root
docker run -it \
    --gpus all \
    --volume=$XSOCK:$XSOCK:rw \
    --volume=$XAUTH:$XAUTH:rw \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume=/:/mydata \
    --env="XAUTHORITY=${XAUTH}" \
    --env="DISPLAY" \
    --net=host \
    --ipc=host \
    hyeonjaegil/kimera-vio:default \
    bash

    # --runtime=nvidia \
    # --env="QT_X11_NO_MITSHM=1" \
xhost -local:root
