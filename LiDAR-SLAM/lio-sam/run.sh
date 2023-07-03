xhost +
docker run --gpus all --rm -it --ipc=host --net=host --privileged \
    --env="DISPLAY" \
    --volume="/etc/localtime:/etc/localtime:ro" \
    hyeonjaegil/lio-sam:latest \
    bash
xhost -