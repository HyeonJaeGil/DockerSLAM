docker run --gpus all --rm -it --ipc=host --net=host --privileged \
    --env="DISPLAY=unix$DISPLAY" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --runtime=nvidia \
    --volume="/home/hj/Dropbox/Dataset/cartographer:/root/dataset" \
    -v /etc/localtime:/etc/localtime:ro \
    cartographer:slam101 \
    /bin/bash
