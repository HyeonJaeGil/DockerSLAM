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
    iputils-ping

RUN apt install -y \
    build-essential \
    libeigen3-dev \
    libsuitesparse-dev \
    freeglut3-dev \
    qtdeclarative5-dev \
    libqglviewer-dev-qt5 \
    libyaml-cpp-dev \
    libopencv-dev

RUN apt install -y python-catkin-tools

# G2O
WORKDIR /opt
RUN wget -O g2o_archive.tar.gz https://github.com/RainerKuemmerle/g2o/archive/refs/tags/20170730_git.tar.gz
RUN tar -xf g2o_archive.tar.gz && rm g2o_archive.tar.gz  
WORKDIR /opt/g2o-20170730_git/build
RUN cmake .. && make -j${CORE}
RUN ln -s ./g2o/config.h ../g2o/core/config.h
RUN make install
ENV G2O_ROOT /usr/local/include/g2o

# Build srrg_proslam
WORKDIR /root/catkin_ws/src
RUN git clone https://gitlab.com/HyeonJaeGil/srrg_proslam.git
WORKDIR /root/catkin_ws/src/srrg_proslam
RUN ["/bin/bash", "-c", "./pull_srrg_packages.bash"]
WORKDIR /root/catkin_ws
RUN . /opt/ros/melodic/setup.sh && \
    catkin build srrg_proslam
RUN rm -rf /var/lib/apt/lists/*
RUN echo source /opt/ros/melodic/setup.bash >> /root/.bashrc
RUN echo source /root/catkin_ws/devel/setup.bash >> /root/.bashrc
WORKDIR /root

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics