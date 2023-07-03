#! /bin/sh
docker_image=$1

# check if docker image exists
if [ "$(docker images -q ${docker_image} 2> /dev/null)" == "" ]; then
    echo "Docker image ${docker_image} does not exist. Build it first."
    exit 1
fi

# run docker container with GUI
xhost +
docker run --gpus all --rm -it --ipc=host --net=host --privileged \
    --env="DISPLAY" \
    --volume="/etc/localtime:/etc/localtime:ro" \
    --volume="$HOME/Downloads/Dataset:/dataset" \
    ${docker_image}
xhost -