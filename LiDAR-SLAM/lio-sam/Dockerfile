FROM osrf/ros:melodic-desktop-full

ENV DEBIAN_FRONTEND noninteractive

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

#ROS dependency
RUN apt install -y ros-melodic-navigation \
                ros-melodic-robot-localization \ 
                ros-melodic-robot-state-publisher
#gtsam
WORKDIR /opt
RUN wget -O /opt/gtsam.zip https://github.com/borglab/gtsam/archive/4.0.2.zip
RUN cd /opt && unzip gtsam.zip -d /opt/ && rm gtsam.zip
WORKDIR /opt/gtsam-4.0.2/build
RUN cmake -DGTSAM_BUILD_WITH_MARCH_NATIVE=OFF -DGTSAM_USE_SYSTEM_EIGEN=ON ..
RUN make -j${core} && make install
RUN rm -rf /opt/gtsam-4.0.2

#ROS workspace
WORKDIR /root/catkin_ws/src
RUN git clone https://github.com/TixiaoShan/LIO-SAM.git
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