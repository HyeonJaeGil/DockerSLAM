FROM hyeonjaegil/ros:melodic-desktop-full
ARG DEBIAN_FRONTEND=noninteractive
ENV core 8

RUN apt update

#ceres
WORKDIR /root
RUN git clone https://ceres-solver.googlesource.com/ceres-solver ceres-solver
RUN apt install -y cmake libgoogle-glog-dev libgflags-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev
WORKDIR /root/ceres-solver/ceres-bin
RUN cmake ..
RUN make -j${core} && make install


#ROS workspace
# RUN apt install -y python-catkin-tools
WORKDIR /root/catkin_ws/src
RUN git clone https://github.com/HKUST-Aerial-Robotics/VINS-Mono.git
WORKDIR /root/catkin_ws
RUN . /opt/ros/melodic/setup.sh && \
    catkin_make
RUN rm -rf /var/lib/apt/lists/*
RUN echo source /opt/ros/melodic/setup.bash >> /root/.bashrc
RUN echo source /root/catkin_ws/devel/setup.bash >> /root/.bashrc

WORKDIR /root

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

