FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-devel

ENV DEBIAN_FRONTEND noninteractive
ENV TMPDIR /tmp/

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC
RUN apt update

RUN apt install -y build-essential  \
    cmake \
    pkg-config  \
    htop  \
    gedit  \
    wget \
    git \
    unzip  \
    curl \
    vim \
    software-properties-common \
    net-tools \
    iputils-ping \ 
    libomp-dev


RUN pip install scikit-learn
RUN pip install opencv-python==3.4.2.17
RUN pip install tensorboard==2.1.1
RUN pip install tensorboardX
RUN pip install protobuf==3.20.*
RUN pip install h5py
RUN pip install faiss-cpu

RUN echo 'cloning packages...' 
RUN git clone https://github.com/HyeonJaeGil/pytorch-NetVlad.git -b docker


# RUN python run.py