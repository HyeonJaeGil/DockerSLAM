FROM osrf/ros:melodic-desktop-full

ARG DEBIAN_FRONTEND=noninteractive
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
    libeigen3-dev \
	libsuitesparse-dev \
	libopencv-dev

# Pangolin
RUN apt update && apt install -y \
	libgl1-mesa-dev \
	libglew-dev \
	libpython2.7-dev \
	ffmpeg libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev \
	libdc1394-22-dev libraw1394-dev \		
	libjpeg-dev libpng-dev libtiff5-dev libopenexr-dev
WORKDIR /opt
RUN wget https://github.com/stevenlovegrove/Pangolin/archive/refs/tags/v0.6.tar.gz \
	&& tar -xzf v0.6.tar.gz && rm v0.6.tar.gz
WORKDIR /opt/Pangolin-0.6/build
RUN cmake .. && make -j${CORE} && make install
WORKDIR /root
RUN rm -rf /opt/Pangolin-0.6

# clone dso first
WORKDIR /root/catkin_ws/src
RUN git clone https://github.com/HyeonJaeGil/dso.git

#ziplib
RUN apt install -y zlib1g-dev
WORKDIR /root/catkin_ws/src/dso/dso_standalone/thirdparty
RUN tar -zxvf libzip-1.1.1.tar.gz && rm libzip-1.1.1.tar.gz 
WORKDIR /root/catkin_ws/src/dso/dso_standalone/thirdparty/libzip-1.1.1
RUN ./configure
RUN make
RUN make install
RUN cp lib/zipconf.h /usr/local/include/zipconf.h

# dso_ros
WORKDIR /root/catkin_ws/src/dso/dso_standalone/build
RUN cmake .. && make -j${CORE} && make install
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
