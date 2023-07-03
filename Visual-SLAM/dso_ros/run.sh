#! /bin/sh
xhost +
docker run --gpus all --rm -it --ipc=host --net=host --privileged \
    --env="DISPLAY" \
    --volume="/etc/localtime:/etc/localtime:ro" \
    --volume="$HOME/Downloads/Dataset:/dataset" \
    --volume="$HOME/Research/dso:/catkin_ws/src/dso" \
    hyeonjaegil/dso-ros:latest 
xhost -