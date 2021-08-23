
FROM hyeonjaegil/opencv:3.4-ros

ARG DEBIAN_FRONTEND=noninteractive
ENV CORE 8

# Pangolin
RUN apt update && apt install -y \
		libgl1-mesa-dev \
		libglew-dev \
		libpython2.7-dev \
		ffmpeg libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev \
		libdc1394-22-dev libraw1394-dev \		
		libjpeg-dev libpng-dev libtiff5-dev libopenexr-dev

WORKDIR /root/libraries/pangolin
RUN git clone https://github.com/stevenlovegrove/Pangolin.git Pangolin
WORKDIR Pangolin/build
RUN cmake .. && make -j{CORE}

# Eigen3
WORKDIR /root/Libraries/Eigen3
RUN git clone -b 3.2 https://gitlab.com/libeigen/eigen.git eigen
WORKDIR eigen/build
RUN cmake .. && make -j{CORE}

# Orb-slam2
RUN apt update && apt install -y \
	libboost-all-dev  \
	apt-utils \
	libsuitesparse-dev   \
	qtdeclarative5-dev   \
	qt5-qmake   \
	libqglviewer-dev-qt5

WORKDIR /root/ORB_SLAM2
RUN git clone https://github.com/HyeonJaeGil/ORB_SLAM2_review.git ORB_SLAM2  
WORKDIR ORB_SLAM2
RUN chmod +x build.sh && ./build.sh

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
