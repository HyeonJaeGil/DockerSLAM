FROM nvcr.io/nvidia/l4t-base:r32.4.4

# add new sudo user
# ENV USERNAME melodic
# ENV HOME /home/$USERNAME
# RUN useradd -m $USERNAME && \
#     echo "$USERNAME:$USERNAME" | chpasswd && \
#     usermod --shell /bin/bash $USERNAME && \
#     usermod -aG sudo $USERNAME && \
#     echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
#     chmod 0440 /etc/sudoers.d/$USERNAME && \
#     # Replace 1000 with your user/group id
#     usermod  --uid 1000 $USERNAME && \
#     groupmod --gid 1000 $USERNAME && \
#     gpasswd -a $USERNAME video

# install package
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
        sudo \
        build-essential \
        git \
        less \
        vim \
        tmux \
        bash-completion \
        command-not-found \
        software-properties-common \
        xdg-user-dirs \
        xsel \
        dirmngr \
        gpg-agent \
        mesa-utils \
        libglu1-mesa-dev \
        libgles2-mesa-dev \
        freeglut3-dev \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ROS Melodic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt-get update && apt-get install -y --no-install-recommends \
        ros-melodic-desktop-full \
        python-rosdep \
        python-rosinstall \
        python-rosinstall-generator \
        python-wstool \
        build-essential \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN rosdep init

# USER $USERNAME
# WORKDIR /home/$USERNAME
RUN rosdep update
SHELL ["/bin/bash", "-c"]
RUN echo "export PATH=/usr/local/cuda/bin:$PATH" >> ~/.bashrc && \
    echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH" >> ~/.bashrc && \
    echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc && \
    source ~/.bashrc