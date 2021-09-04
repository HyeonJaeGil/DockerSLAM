FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive
ENV CORE 8

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
	vim

RUN apt install -y libsuitesparse-dev libeigen3-dev libboost-all-dev

WORKDIR /root
RUN git clone https://github.com/JakobEngel/dso.git

# Pangolin
RUN apt update && apt install -y \
		libgl1-mesa-dev \
		libglew-dev \
		libpython2.7-dev \
		ffmpeg libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev \
		libdc1394-22-dev libraw1394-dev \		
		libjpeg-dev libpng-dev libtiff5-dev libopenexr-dev


WORKDIR /root/Libraries
RUN git clone https://github.com/stevenlovegrove/Pangolin.git Pangolin && cd Pangolin && git checkout v0.6
WORKDIR /root/Libraries/Pangolin/build
RUN cmake .. && make -j${CORE}

RUN apt install -y libopencv-dev


#ziplib
RUN apt install -y zlib1g-dev
WORKDIR /root/dso/thirdparty
RUN tar -zxvf libzip-1.1.1.tar.gz
WORKDIR /root/dso/thirdparty/libzip-1.1.1
RUN ./configure
RUN make -j${CORE} && make install
RUN cp lib/zipconf.h /usr/local/include/zipconf.h

#dso
WORKDIR /root/dso/build
RUN cmake .. && make -j${CORE}

RUN rm -rf /var/lib/apt/lists/*