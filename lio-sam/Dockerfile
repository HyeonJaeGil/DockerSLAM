FROM hyeonjaegil/ros:kinetic-desktop-full
ARG DEBIAN_FRONTEND=noninteractive
ENV core 8

RUN apt update

# # Eigen3
# WORKDIR /root/Libraries/Eigen3
# RUN git clone -b 3.3 https://gitlab.com/libeigen/eigen.git eigen
# WORKDIR /root/Libraries/Eigen3/eigen/build
# RUN cmake .. && make -j${CORE} && make install
# RUN export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:/Eigen/install


#ROS dependency
RUN apt install -y ros-kinetic-navigation \
                ros-kinetic-robot-localization \ 
                ros-kinetic-robot-state-publisher

#gtsam
WORKDIR /root/Libraries
RUN wget -O /root/Libraries/gtsam.zip https://github.com/borglab/gtsam/archive/4.0.2.zip
RUN cd /root/Libraries && unzip gtsam.zip -d /root/Libraries/ && rm gtsam.zip
WORKDIR /root/Libraries/gtsam-4.0.2/build
RUN cmake -DGTSAM_BUILD_WITH_MARCH_NATIVE=OFF -DGTSAM_USE_SYSTEM_EIGEN=ON ..
# RUN cmake -DGTSAM_BUILD_WITH_MARCH_NATIVE=OFF ..
RUN make -j${core} && make install

# #PCL
# WORKDIR /root/Libraries/PCL
# RUN wget https://github.com/PointCloudLibrary/pcl/archive/pcl-1.7.1.tar.gz && tar zvfx pcl-1.7.1.tar.gz
# WORKDIR /root/Libraries/PCL/pcl-pcl-1.7.1/build
# RUN cmake .. && make -j4  && make install
# RUN apt install -y ros-kinetic-pcl-conversions ros-kinetic-pcl-ros

#ROS workspace
# RUN apt install -y python-catkin-tools
WORKDIR /root/catkin_ws/src
# RUN git clone https://github.com/TixiaoShan/LIO-SAM.git
RUN git clone https://github.com/HyeonJaeGil/SC-LIO-SAM.git
WORKDIR /root/catkin_ws
RUN . /opt/ros/kinetic/setup.sh && \
    catkin_make
RUN rm -rf /var/lib/apt/lists/*
RUN echo source /opt/ros/kinetic/setup.bash >> /root/.bashrc
RUN echo source /root/catkin_ws/devel/setup.bash >> /root/.bashrc


# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

