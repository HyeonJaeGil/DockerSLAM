FROM hyeonjaegil/xavier:opencv3.4
ARG DEBIAN_FRONTEND=noninteractive

ENV CORE 7

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

#gtsam
WORKDIR /root/Libraries
RUN git clone https://github.com/borglab/gtsam.git gtsam
WORKDIR gtsam/build
RUN cmake -DGTSAM_BUILD_WITH_MARCH_NATIVE=OFF -DGTSAM_USE_SYSTEM_EIGEN=ON ..
RUN make -j${CORE} && make install

#g2o
RUN apt install -y libsuitesparse-dev qtdeclarative5-dev qt5-qmake libqglviewer-dev-qt5
# WORKDIR /root/Libraries
# RUN git clone https://github.com/RainerKuemmerle/g2o.git
# WORKDIR g2o/build
# RUN cmake -DBUILD_WITH_MARCH_NATIVE=OFF ..
# RUN make -j8 && make install

#octomap
# libQGLViewer could not be found or generated. How to solve?
RUN apt remove ros-melodic-octomap -y
WORKDIR /root/Libraries
RUN git clone https://github.com/OctoMap/octomap.git 
WORKDIR octomap/build
RUN cmake .. && make -j${CORE}
RUN make install

#rtabmap
RUN apt install libqt5svg5-dev -y
WORKDIR /root
RUN git clone https://github.com/introlab/rtabmap.git rtabmap
WORKDIR rtabmap/build
RUN cmake ..
RUN make -j${CORE} && make install
RUN rm /root/rtabmap/build/CMakeCache.txt

#rtabmap-ros
WORKDIR /root/catkin_ws/src
RUN git clone https://github.com/hyeonjaegil/rtabmap_ros.git
WORKDIR /root/catkin_ws
# RUN /bin/bash -c '. /opt/ros/melodic/setup.bash'
# RUN catkin build -j${CORE}
RUN catkin config \
      --extend /opt/ros/melodic && \
    catkin build -j${CORE}

RUN cd /usr/lib/aarch64-linux-gnu/ && ln -sf libGL.so.1.0.0 libGL.so

RUN ln -s /usr/lib/aarch64-linux-gnu/libvtkCommonCore-6.2.so /usr/lib/libvtkproj4.so

RUN ln -s /usr/lib/aarch64-linux-gnu/libvtkCommonCore-6.2.so /usr/lib/aarch64-linux-gnu/libvtkproj4-6.2.so.6.2.0


RUN rm -rf /var/lib/apt/lists/*
# RUN echo source /opt/ros/melodic/setup.bash >> /root/.bashrc
RUN echo source /root/catkin_ws/devel/setup.bash >> /root/.bashrc

# nvidia-container-runtime
# ENV NVIDIA_VISIBLE_DEVICES \
#     ${NVIDIA_VISIBLE_DEVICES:-all}
# ENV NVIDIA_DRIVER_CAPABILITIES \
#     ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN echo "rtabmap ros installation finished."