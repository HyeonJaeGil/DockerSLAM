FROM hyeonjaegil/ros:melodic-desktop-full-nvidia

ARG DEBIAN_FRONTEND=noninteractive

ENV CORE 8

RUN apt update && apt upgrade -y

#install ros dependency
RUN apt install -y ros-melodic-rtabmap ros-melodic-rtabmap-ros
RUN apt remove -y ros-melodic-rtabmap ros-melodic-rtabmap-ros

# opencv3.4
ENV OPENCV_VERSION 3.4.13
WORKDIR /root/opencv${OPENCV_VERSION}
RUN wget -O opencv.zip "https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip" && unzip opencv.zip
RUN	wget -O opencv_contrib.zip "https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip" && unzip opencv_contrib.zip
WORKDIR build
RUN cmake -DCMAKE_BUILD_TYPE=RELEASE -DWITH_CUDA=OFF -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-${OPENCV_VERSION}/modules ../opencv-${OPENCV_VERSION}
RUN make -j${CORE} && make install

#boost, git, cmake, eigen
RUN apt install -y \
	libboost-all-dev \ 
	git  \
	cmake cmake-gui \
	libeigen3-dev

#libnabo 
WORKDIR /root/Libraries
git clone git://github.com/ethz-asl/libnabo.git libnabo
WORKDIR libnabo/build
RUN cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ..
RUN make -j${CORE} && make install

#libpointmatcher
WORKDIR /root/Libraries
git clone git://github.com/ethz-asl/libpointmatcher.git libpointmatcher
WORKDIR libpointmatcher/build
RUN cmake ..
RUN make -j${CORE} && make install

#g2o
# RUN apt install libsuitesparse-dev qtdeclarative5-dev qt5-qmake libqglviewer-dev-qt5
# RUN cd ~/Libraries && git clone https://github.com/RainerKuemmerle/g2o.git && cd g2o
# RUN mkdir -p build && cd build
# RUN cmake -DBUILD_WITH_MARCH_NATIVE=OFF ..
# RUN make -j8 && make install

#gtsam
WORKDIR /root/Libraries
RUN git clone https://github.com/borglab/gtsam.git gtsam
WORKDIR gtsam/build
RUN cmake -DGTSAM_BUILD_WITH_MARCH_NATIVE=OFF -DGTSAM_USE_SYSTEM_EIGEN=ON ..
RUN make -j${CORE} && make install

#rtabmap
WORKDIR /root
git clone https://github.com/introlab/rtabmap.git rtabmap
WORKDIR rtabmap/build
RUN cmake ..
RUN make -j8 && make install


#vision-opencv, image_transport
WORKDIR /root/catkin_ws/src
RUN apt install python-catkin-tools -y
RUN git clone https://github.com/ros-perception/vision_opencv.git -b melodic && git clone https://github.com/ros-perception/image_transport_plugins.git
RUN catkin build -j${CORE}

#rtabmap-ros
WORKDIR /root/catkin_ws/src
RUN git clone https://github.com/introlab/rtabmap_ros.git
RUN catkin build -j${CORE}
