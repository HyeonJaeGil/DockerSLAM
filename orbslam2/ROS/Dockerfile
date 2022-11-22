
FROM hyeonjaegil/melodic:opencv3.4

ARG DEBIAN_FRONTEND=noninteractive
ENV CORE 8

RUN apt install -y libeigen3-dev
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

WORKDIR /root/libraries
RUN wget https://github.com/stevenlovegrove/Pangolin/archive/refs/tags/v0.6.tar.gz
RUN tar -xzf v0.6.tar.gz
WORKDIR /root/libraries/Pangolin-0.6/build
RUN cmake .. && make -j${CORE} && make install
WORKDIR /root/libraries
RUN rm -r Pangolin-0.6 && rm v0.6.tar.gz
WORKDIR /root
RUN rm -r /root/libraries

RUN ldconfig

# orbslam2
RUN apt update && apt install -y \
	libboost-all-dev  \
	apt-utils \
	libsuitesparse-dev   \
	qtdeclarative5-dev   \
	qt5-qmake   \
	libqglviewer-dev-qt5

WORKDIR /root
RUN git clone https://github.com/HyeonJaeGil/ORB_SLAM2.git ORB_SLAM2  
WORKDIR /root/ORB_SLAM2
RUN chmod +x build.sh && ./build.sh 

# orbslam2-ros
RUN apt install -y python-catkin-tools
WORKDIR /root/catkin_ws/src
RUN git clone https://github.com/HyeonJaeGil/orbslam-ros.git
WORKDIR /root/catkin_ws
RUN . /opt/ros/melodic/setup.sh && \
    catkin build
RUN rm -rf /var/lib/apt/lists/*
RUN echo source /opt/ros/melodic/setup.bash >> /root/.bashrc
RUN echo source /root/catkin_ws/devel/setup.bash >> /root/.bashrc

ENTRYPOINT [ "/bin/bash" ]

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
