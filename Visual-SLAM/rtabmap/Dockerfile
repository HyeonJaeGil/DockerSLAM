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

#install ros dependency
RUN apt install -y ros-melodic-rtabmap ros-melodic-rtabmap-ros
RUN apt remove -y ros-melodic-rtabmap ros-melodic-rtabmap-ros

#boost, git, cmake, eigen
RUN apt install -y \
	libboost-all-dev \ 
	git  \
	cmake cmake-gui \
	libeigen3-dev

#libnabo 
WORKDIR /opt
RUN git clone git://github.com/ethz-asl/libnabo.git libnabo
WORKDIR /opt/libnabo/build
RUN cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ..
RUN make -j${CORE} && make install

#libpointmatcher
WORKDIR /opt
RUN git clone git://github.com/ethz-asl/libpointmatcher.git libpointmatcher
WORKDIR /opt/libpointmatcher/build
RUN cmake ..
RUN make -j${CORE} && make install

#gtsam
WORKDIR /opt
RUN git clone https://github.com/borglab/gtsam.git -b 4.1 gtsam
WORKDIR /opt/gtsam/build
RUN cmake -DGTSAM_BUILD_WITH_MARCH_NATIVE=OFF -DGTSAM_USE_SYSTEM_EIGEN=ON ..
RUN make -j${CORE} && make install

#g2o
RUN apt install -y libsuitesparse-dev qtdeclarative5-dev qt5-qmake libqglviewer-dev-qt5

#octomap
RUN apt remove ros-melodic-octomap -y
WORKDIR /opt
RUN git clone https://github.com/OctoMap/octomap.git 
WORKDIR /opt/octomap/build
RUN cmake .. && make -j${CORE} && make install

#rtabmap
RUN apt install libqt5svg5-dev -y
WORKDIR /root
RUN git clone https://github.com/introlab/rtabmap.git rtabmap
WORKDIR /root/rtabmap/build
RUN cmake .. && make -j${CORE} && make install
RUN rm /root/rtabmap/build/CMakeCache.txt

#rtabmap-ros
WORKDIR /root/catkin_ws/src
RUN git clone https://github.com/introlab/rtabmap_ros.git
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

RUN echo "rtabmap ros installation finished."