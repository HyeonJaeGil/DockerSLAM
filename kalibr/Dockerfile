FROM stereolabs/kalibr:kinetic
ARG DEBIAN_FRONTEND=noninteractive
ENV core 8

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys AB17C654
RUN apt update
RUN apt install -y python-pyx


# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

