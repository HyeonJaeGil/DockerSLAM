FROM hyeonjaegil/xavier:melodic

ARG DEBIAN_FRONTEND=noninteractive

#set env variables
ENV OPENCV_VERSION 3.4.13
ENV CORE 6

#core packages for opencv
RUN apt update && apt upgrade -y
RUN apt install -y \
	apt-utils \
	build-essential \
	cmake \
	pkg-config \
	htop \
	gedit \
	wget \
	git \
	unzip \
	curl \
	vim \
	software-properties-common \
	libgtk2.0-dev \
	net-tools \ 
	iputils-ping \
	libboost-all-dev \
	ffmpeg \
	libgstreamer1.0-dev  \
	libgstreamer-plugins-base1.0-dev  \
	libgstreamer-plugins-bad1.0-dev  \
	gstreamer1.0-plugins-base  \
	gstreamer1.0-plugins-good  \
	gstreamer1.0-plugins-bad \
	gstreamer1.0-plugins-ugly  \
	gstreamer1.0-libav  \
	gstreamer1.0-doc  \
	gstreamer1.0-tools  \
	gstreamer1.0-x \
	gstreamer1.0-alsa  \
	gstreamer1.0-gl \
	gstreamer1.0-gtk3  \
	gstreamer1.0-qt5  \
	gstreamer1.0-pulseaudio
		
#clone and build opencv
WORKDIR /root/opencv${OPENCV_VERSION}
RUN wget -O opencv.zip "https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip" && unzip opencv.zip
RUN	wget -O opencv_contrib.zip "https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip" && unzip opencv_contrib.zip

WORKDIR build
RUN cmake -DCMAKE_BUILD_TYPE=RELEASE -DWITH_CUDA=OFF -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-${OPENCV_VERSION}/modules ../opencv-${OPENCV_VERSION}
RUN make -j${CORE} && make install

# ROS related

WORKDIR /root/catkin_ws/src
RUN apt install python-catkin-tools -y
RUN git clone https://github.com/ros-perception/vision_opencv.git -b melodic && \
	git clone https://github.com/ros-perception/image_transport_plugins.git

WORKDIR /root/catkin_ws
RUN catkin config \
      --extend /opt/ros/melodic && \
    catkin build 
RUN echo "Installation finished!"	

