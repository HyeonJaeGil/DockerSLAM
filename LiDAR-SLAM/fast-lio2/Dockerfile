FROM osrf/ros:melodic-desktop-full

ENV DEBIAN_FRONTEND noninteractive
ENV CORE 8

RUN apt update && apt upgrade -y

RUN apt install -y \
    build-essential  \
    cmake \
    pkg-config  \
    htop  \
    gedit  \
    wget \
    git \
    unzip  \
    curl \
    vim \
    software-properties-common \
    libboost-all-dev \
    net-tools \
    iputils-ping \
    libeigen3-dev

# Livox-SDK
WORKDIR /opt
RUN wget -O /opt/Livox-SDK.zip https://github.com/Livox-SDK/Livox-SDK/archive/refs/tags/v2.3.0.zip
RUN cd /opt && unzip Livox-SDK.zip -d /opt/ && rm Livox-SDK.zip
WORKDIR /opt/Livox-SDK-2.3.0/build
RUN cmake .. && make -j${CORE} && make install
RUN rm -rf /opt/Livox-SDK-2.3.0

# Livox-ROS-Driver
WORKDIR /root/catkin_ws/src
RUN wget -O /root/catkin_ws/src/Livox-ROS-Driver.zip \
    https://github.com/Livox-SDK/livox_ros_driver/archive/refs/tags/v2.6.0.zip
RUN cd /root/catkin_ws/src && unzip Livox-ROS-Driver.zip -d /root/catkin_ws/src/ && rm Livox-ROS-Driver.zip
WORKDIR /root/catkin_ws
RUN . /opt/ros/melodic/setup.sh && \
    catkin_make

#ROS workspace
WORKDIR /root/catkin_ws/src
RUN git clone --recursive https://github.com/hku-mars/FAST_LIO.git
WORKDIR /root/catkin_ws
RUN . /opt/ros/melodic/setup.sh && \
    catkin_make
RUN rm -rf /var/lib/apt/lists/*
RUN echo source /opt/ros/melodic/setup.bash >> /root/.bashrc
RUN echo source /root/catkin_ws/devel/setup.bash >> /root/.bashrc

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics


ENTRYPOINT [ "/bin/bash" ]