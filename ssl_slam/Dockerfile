FROM hyeonjaegil/ros:melodic-desktop-full
ARG DEBIAN_FRONTEND=noninteractive
ENV core 8

RUN apt update

# Eigen3
WORKDIR /root/Libraries/Eigen3
RUN git clone -b 3.3 https://gitlab.com/libeigen/eigen.git eigen
WORKDIR /root/Libraries/Eigen3/eigen/build
RUN cmake .. && make -j${CORE} && make install

# ceres
WORKDIR /root/Libraries/ceres
RUN git clone https://ceres-solver.googlesource.com/ceres-solver ceres-solver
RUN apt install -y cmake libgoogle-glog-dev libgflags-dev libatlas-base-dev libsuitesparse-dev
WORKDIR /root/Libraries/ceres/ceres-bin
RUN cmake ../ceres-solver
RUN make -j4 && make install

#gtsam
WORKDIR /root/Libraries
RUN git clone https://github.com/borglab/gtsam.git gtsam
WORKDIR /root/Libraries/gtsam/build
RUN cmake -DGTSAM_BUILD_WITH_MARCH_NATIVE=OFF -DGTSAM_USE_SYSTEM_EIGEN=ON ..
RUN make -j4 && make install