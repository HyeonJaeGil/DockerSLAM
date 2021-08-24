FROM hyeonjaegil/opencv:3.4-ros
ARG DEBIAN_FRONTEND=noninteractive

ENV CORE 8

RUN apt update && apt upgrade -y

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
WORKDIR /root/Libraries
RUN git clone git://github.com/ethz-asl/libnabo.git libnabo
WORKDIR libnabo/build
RUN cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ..
RUN make -j${CORE} && make install

#libpointmatcher
WORKDIR /root/Libraries
RUN git clone git://github.com/ethz-asl/libpointmatcher.git libpointmatcher
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
RUN git clone https://github.com/introlab/rtabmap.git rtabmap
WORKDIR rtabmap/build
RUN cmake ..
RUN make -j8 && make install


#vision-opencv, image_transport
# WORKDIR /root/catkin_ws/src
# RUN apt install python-catkin-tools -y
# RUN git clone https://github.com/ros-perception/vision_opencv.git -b melodic && git clone https://github.com/ros-perception/image_transport_plugins.git
# RUN catkin build -j${CORE}

#rtabmap-ros
WORKDIR /root/catkin_ws/src
RUN git clone https://github.com/introlab/rtabmap_ros.git
WORKDIR /root/catkin_ws
# RUN catkin build -j${CORE}

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN echo "rtabmap ros installation finished."