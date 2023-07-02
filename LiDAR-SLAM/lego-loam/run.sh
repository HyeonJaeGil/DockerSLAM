xhost +
docker run --gpus all --rm -it --ipc=host --net=host --privileged \
    --env="DISPLAY=unix$DISPLAY" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --volume="/home/hj/Downloads/Dataset:/root/dataset" \
    -v /etc/localtime:/etc/localtime:ro \
    hyeonjaegil/lego-loam:melodic \
    /bin/bash
xhost -