docker run --gpus all --rm -it --ipc=host --net=host --privileged \
    --env="DISPLAY=unix$DISPLAY" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --runtime=nvidia \
    --volume="/home/hj/Dropbox/SNU/Lectures/2022-Fall/SLAM101/week10/Data:/root/dataset" \
    -v /etc/localtime:/etc/localtime:ro \
    hyeonjaegil/orbslam2:ros \
    /bin/bash