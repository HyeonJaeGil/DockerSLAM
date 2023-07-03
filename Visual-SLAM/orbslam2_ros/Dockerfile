FROM ubuntu:18.04

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
	libopencv-dev

WORKDIR /usr/local/include
RUN ln -sf eigen3/Eigen Eigen && ln -sf eigen3/unsupported unsupported

# Pangolin
RUN apt update && apt install -y \
		libgl1-mesa-dev \
		libglew-dev \
		libpython2.7-dev \
		ffmpeg libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev \
		libdc1394-22-dev libraw1394-dev \		
		libjpeg-dev libpng-dev libtiff5-dev libopenexr-dev
WORKDIR /opt
RUN wget https://github.com/stevenlovegrove/Pangolin/archive/refs/tags/v0.6.tar.gz
RUN tar -xzf v0.6.tar.gz
WORKDIR /opt/Pangolin-0.6/build
RUN cmake .. && make -j${CORE} && make install
RUN ldconfig
WORKDIR /opt
RUN rm -r Pangolin-0.6 && rm v0.6.tar.gz
WORKDIR /root

# Orb-slam2
RUN apt update && apt install -y \
	libboost-all-dev  \
	apt-utils \
	libsuitesparse-dev   \
	qtdeclarative5-dev   \
	qt5-qmake   \
	libqglviewer-dev-qt5 \
	libpython2.7-dev

WORKDIR /root
# RUN git clone https://github.com/HyeonJaeGil/ORB_SLAM2.git ORB_SLAM2
RUN git clone https://github.com/UZ-SLAMLab/ORB_SLAM3.git ORB_SLAM3
WORKDIR /root/ORB_SLAM3
RUN chmod +x build.sh && ./build.sh 
RUN rm -rf /var/lib/apt/lists/*
WORKDIR /root/ORB_SLAM3

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

ENTRYPOINT [ "/bin/bash" ]