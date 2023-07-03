# DockerSLAM
## User-friendly way to run SLAM on Docker

This is a personal Dockerfile hub for SLAM algorithms.
Since SLAM consists of various modules, it is quite hard for a beginner to compile and run them from scratch.
**This DockerSLAM repository is suitable for SLAM beginners. All you need is to install Docker beforehand!**

## Supported SLAM algorithm
### LiDAR SLAM

<center>

| LiDAR SLAM | Link to original repository | Link to Docker Hub |
| :--------: | :-------------------------: | :----------------: |
| FAST-LIO2  |          FAST-LIO2          |     Docker hub     |
| LEGO-LOAM  |          LEGO-LOAM          |     Docker hub     |
|  LIO-SAM   |           LIO-SAM           |     Docker hub     |

</center>

### Visual SLAM
<center>

| Visual SLAM | Link to original repository | Link to Docker Hub |
| :---------: | :-------------------------: | :----------------: |
|     DSO     |             DSO             |     Docker hub     |
|  ORB-SLAM2  |          ORB-SLAM2          |     Docker hub     |
|  VINS-Mono  |          VINS-Mono          |     Docker hub     |
|   RTABMap   |           RTABMap           |     Docker hub     |
|   PL-VINS   |           PL-VINS           |     Docker hub     |
|   PL-VIO    |           PL-VIO            |     Docker hub     |
|   ProSLAM   |           ProSLAM           |     Docker hub     |

</center>


## How to use
### 0. Install Prerequisite
#### Docker
Please follow the [official guidance link](https://docs.docker.com/engine/install/ubuntu/) to install Docker.
Make sure to perform [post-installation step](https://docs.docker.com/engine/install/linux-postinstall/), especially adding docker to your group.
```bash
newgroup docker
```
#### NVIDIA-Docker
In order to use `--gpus all` option when running a container, please install [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#step-1-install-nvidia-container-toolkit) properly.

### 1. Prepare Docker Image
First, check available algorithm (vins-mono, lio-sam, ... ) for Docker image. 
You can either build it by yourself...
```bash
./build.sh <target_algorithm>
```
or just pull from dockerhub
```bash
docker pull hyeonjaegil/<target_algorithm>:latest
```

Check if image is ready with `$ docker images` command.

### 2. Run Container
```bash
./run <target_algorithm>
```

#### Customizing [run.sh](./run.sh) File
1. You can modify [run.sh](./run.sh) to use extra options, such as `--volume` option to mount your directories.
For example, mount local `~/Download/Dataset` folder into container `/dataset` folder.
```sh
# Inside run.sh file...

docker run --gpus all --rm -it --ipc=host --net=host --privileged \
    --env="DISPLAY" \
    --volume="/etc/localtime:/etc/localtime:ro" \
    --volume="$HOME/Downloads/Dataset:/dataset" \ # add this line.
    ${docker_image}
```

2. If you don't want to delete container when exiting, please remove `--rm` options.


**Be aware that current `run.sh` file gives container the highest authority.**
- It gives all available GPUs (`--gpus all`),
- gives maximum shared memory (`--ipc host`),
- offers the same network stack with host (`--net host`),
- and gives access to all the devices on the host (`--privileged`)
- AND container can connect from any host (`xhost +`)
