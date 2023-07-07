#! /bin/sh
IMAGE_NAME=$1

# check if docker_image is empty
if [ -z "$IMAGE_NAME" ]; then
    echo "Please specify docker image name."
    exit 1
fi

# check if docker image exists
if [ -z "$(docker images -q "$IMAGE_NAME")" ]; then
    echo "Docker image ${IMAGE_NAME} does not exist. Build it first."
    exit 1
fi

# run docker container with GUI
xhost +
docker run --gpus all --rm -it --ipc=host --net=host --privileged \
    --env="DISPLAY" \
    --volume="/etc/localtime:/etc/localtime:ro" \
    --volume="$HOME/Downloads/Dataset:/dataset" \
    ${IMAGE_NAME}
xhost -