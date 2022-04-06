FROM hyeonjaegil/opencv3.4:melodic
ENV core 8

RUN apt update

#ceres
WORKDIR /root
# RUN git clone https://ceres-solver.googlesource.com/ceres-solver ceres-solver
RUN wget http://ceres-solver.org/ceres-solver-2.0.0.tar.gz && tar -xvf ceres-solver-2.0.0.tar.gz && mv ceres-solver-2.0.0 ceres-solver && rm ceres-solver-2.0.0.tar.gz
RUN apt install -y cmake libgoogle-glog-dev libgflags-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev
WORKDIR /root/ceres-solver/ceres-bin
RUN cmake ..
RUN make -j${core} && make install


#ROS workspace
RUN apt install -y python-catkin-tools
WORKDIR /root/catkin_ws/src
RUN git clone https://github.com/HyeonJaeGil/PL-VIO.git -b docker
WORKDIR /root/catkin_ws
RUN . /opt/ros/melodic/setup.sh && \
    catkin build camera_model
RUN . /opt/ros/melodic/setup.sh && \
    catkin build
RUN rm -rf /var/lib/apt/lists/*
RUN echo source /opt/ros/melodic/setup.bash >> /root/.bashrc
RUN echo source /root/catkin_ws/devel/setup.bash >> /root/.bashrc

WORKDIR /root

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

