FROM hyeonjaegil/opencv:4.5

ARG DEBIAN_FRONTEND=noninteractive

#set env variables
ENV CORE 8

#eigen3
RUN apt update && apt install -y libeigen3-dev

#Sophus
WORKDIR /root
RUN git clone https://github.com/strasdat/Sophus.git Sophus
RUN apt install libfmt-dev
WORKDIR /root/Sophus/build
RUN cmake .. && make -j${CORE} && make install

#ceres
WORKDIR /root
RUN git clone https://ceres-solver.googlesource.com/ceres-solver ceres-solver
RUN apt install -y cmake libgoogle-glog-dev libgflags-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev
WORKDIR /root/ceres-solver/ceres-bin
RUN cmake .. && make -j${CORE} && make install

#g2o
WORKDIR /root
RUN git clone https://github.com/RainerKuemmerle/g2o.git g2o
RUN apt install -y cmake libeigen3-dev libsuitesparse-dev qtdeclarative5-dev qt5-qmake libqglviewer-dev-qt5
WORKDIR /root/g2o/build
RUN cmake .. && make -j${CORE} && make install
