XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run -it \
    --volume=$XSOCK:$XSOCK:rw \
    --volume=$XAUTH:$XAUTH:rw \
    --env="ROS_MASTER_URI=http://172.17.0.1:11311" \
    --env="ROS_IP=172.17.0.2" \
    --env="XAUTHORITY=${XAUTH}" \
    --env="DISPLAY" \
    --volume="/home/hj/Downloads/00:/root/dataset/00" \
    hyeonjaegil/proslam:melodic \
    bash