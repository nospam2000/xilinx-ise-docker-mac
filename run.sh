#!/bin/sh

# possible commands: 
#   /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/ise
#   /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/fpga_editor
#   /opt/Xilinx/14.7/ISE_DS/common/bin/lin64/xlcm
cmd="-c /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/ise"

docker run -it --rm \
    -v "${HOME}/Documents/Xilinx/code:/code" \
    -v "${HOME}/Documents/Xilinx/lic:/xilinx" \
    -e "DISPLAY=host.docker.internal:1" \
    -e XILINXD_LICENSE_FILE=/xilinx/Xilinx.lic \
    -e HOME=/code \
    -u "$(id -u):$(id -g)" \
    --entrypoint "/opt/entrypoint.sh" \
    --mac-address=02:43:ac:11:ff:fe  \
    --hostname=xilinx \
    xilinx-ise $cmd

    #xilinx-ise $*
    #--ip=172.17.0.2 \
    #--mac-address=02:42:ac:11:00:02  \
    #-v $(pwd):/code \
    #-v /sys:/sys:ro \
    #-v /tmp/.X11-unix:/tmp/.X11-unix \


#license files:
#/opt/Xilinx/14.7/ISE_DS/EDK/data/core_licenses/Xilinx.lic
#/opt/Xilinx/14.7/ISE_DS/ISE/coregen/core_licenses/Xilinx.lic
#/opt/Xilinx/14.7/ISE_DS/ISE/coregen/core_licenses/XilinxFree.lic

