docker run -it \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="ROS_MASTER_URI=http://172.17.0.1:11311" \
    --env="ROS_IP=172.17.0.2" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --runtime=nvidia \
    --volume="/home/hj/Dropbox/dataset:/root/dataset" \
    hyeonjaegil/lio-sam:kinetic \
    bash
