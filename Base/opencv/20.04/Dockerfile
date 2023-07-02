FROM hyeonjaegil/ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

#set env variables
ENV OPENCV_VERSION 4.5.3
ENV CORE 8

#clone and build opencv
WORKDIR /root/opencv${OPENCV_VERSION}
RUN wget -O opencv.zip "https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip" && unzip opencv.zip
RUN	wget -O opencv_contrib.zip "https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip" && unzip opencv_contrib.zip

WORKDIR /root/opencv${OPENCV_VERSION}/build
RUN cmake -DCMAKE_BUILD_TYPE=RELEASE -DWITH_CUDA=OFF -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-${OPENCV_VERSION}/modules ../opencv-${OPENCV_VERSION}
RUN make -j${CORE} && make install
WORKDIR /root
RUN rm -r /root/opencv${OPENCV_VERSION}
RUN echo "Installation finished!"