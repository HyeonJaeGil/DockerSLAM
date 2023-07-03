#! /bin/sh
image=$1
xhost +
docker run --gpus all --rm -it --ipc=host --net=host --privileged \
    --env="DISPLAY" \
    --volume="/etc/localtime:/etc/localtime:ro" \
    --volume="$HOME/Downloads/Dataset:/dataset" \
    ${image}
xhost -