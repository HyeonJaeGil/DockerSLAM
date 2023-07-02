FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

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
	gstreamer1.0-pulseaudio && \ 
	rm -rf /var/lib/apt/lists/*
		
RUN echo "Installation finished!"	


