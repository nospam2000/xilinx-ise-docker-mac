#!/bin/sh

# you might need to change this to ":0" depending on your environment
DISPLAY_POSTFIX=":1"

# possible commands: 
#   /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/ise
#   /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/fpga_editor
#   /opt/Xilinx/14.7/ISE_DS/common/bin/lin64/xlcm
cmd="-c /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/ise"

docker run -it --rm \
    -v "${HOME}/Documents/Xilinx/code:/code" \
    -v "${HOME}/Documents/Xilinx/lic:/xilinx" \
    -e "DISPLAY=host.docker.internal${DISPLAY_POSTFIX}" \
    -e XILINXD_LICENSE_FILE=/xilinx/Xilinx.lic \
    -e HOME=/code \
    -u "$(id -u):$(id -g)" \
    --entrypoint "/opt/entrypoint.sh" \
    --mac-address=02:43:ac:11:ff:fe  \
    --hostname=xilinx \
    xilinx-ise $cmd
