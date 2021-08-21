#!/bin/sh
docker run \
        --name xilinx-ise-installer \
        -v ${HOME}/.Xauthority:/home/xilinx/.Xauthority:ro \
        -v ${PWD}/data:/opt/data \
        -v ${PWD}/assets:/opt/assets:ro \
        -it \
        -e "DISPLAY=host.docker.internal:1" \
        --network=host \
        --entrypoint "/opt/assets/Xilinx_ISE_DS_14.7_1015_1/xsetup" \
        xilinx-ise

echo "creating docker image from docker container. This will take soe minutes, please don't interrupt!"
docker commit xilinx-ise-installer xilinx-ise

        #--entrypoint "/bin/bash" \
        #-u xilinx \
        #-v /tmp/.X11-unix:/tmp/.X11-unix \
        #-v /sys:/sys:ro \
