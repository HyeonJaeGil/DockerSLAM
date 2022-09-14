nvidia-docker run --gpus all --rm -it --ipc=host \
-v /home/hj/dockerroot:/mydata \
--name netvlad_cuda113 hyeonjaegil/netvlad:cuda113 bash