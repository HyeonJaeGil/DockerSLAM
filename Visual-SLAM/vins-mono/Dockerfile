FROM osrf/ros:melodic-desktop-full

ARG DEBIAN_FRONTEND=noninteractive
ENV core 8

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
    iputils-ping

#ceres
WORKDIR /root
RUN wget https://github.com/ceres-solver/ceres-solver/archive/refs/tags/2.0.0.tar.gz
RUN tar zxf 2.0.0.tar.gz
RUN apt install -y cmake libgoogle-glog-dev libgflags-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev
WORKDIR /root/ceres-solver-2.0.0/ceres-bin
RUN cmake ..
RUN make -j${core} && make install

# ROS dependencies
RUN apt install \
    ros-melodic-cv-bridge \
    ros-melodic-tf \
    ros-melodic-message-filters \
    ros-melodic-image-transport

# VINS-Mono
RUN apt install -y python-catkin-tools
WORKDIR /root/catkin_ws/src
RUN git clone https://github.com/HKUST-Aerial-Robotics/VINS-Mono.git
WORKDIR /root/catkin_ws
RUN . /opt/ros/melodic/setup.sh && \
    catkin build
RUN rm -rf /var/lib/apt/lists/*
RUN echo source /opt/ros/melodic/setup.bash >> /root/.bashrc
RUN echo source /root/catkin_ws/devel/setup.bash >> /root/.bashrc
WORKDIR /root/catkin_ws

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

ENTRYPOINT [ "/bin/bash" ]